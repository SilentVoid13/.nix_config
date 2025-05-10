#!/usr/bin/env python3
import subprocess
import re
import time
import atexit
import signal
from datetime import datetime
from pathlib import Path

# === CONFIGURATION ===
DRIVE1_DEV = "/dev/sdb"
DRIVE2_DEV = "/dev/sda1"
BORG_SUBDIR = "borg"
GDRIVE_REMOTE = "gdrive:backup"
mounted_devices = []
unlocked_devices = []

# === HELPERS ===


def run(cmd, check=True, capture_output=False):
    print(f"> {cmd}")
    return subprocess.run(
        cmd, shell=True, check=check, text=True, capture_output=capture_output
    )


def unlock_and_mount_luks(dev: str) -> Path:
    # Unlock the LUKS device
    print(f"Unlocking LUKS device {dev}")
    unlock_proc = run(f"udisksctl unlock -b {dev}", capture_output=True)

    # Extract mapper path from stdout
    match = re.search(r"Unlocked .* as (.+)\.", unlock_proc.stdout)
    if not match:
        print(f"[!] Failed to parse unlocked device path from: {unlock_proc.stdout}")
        exit(1)
    unlocked_path = match.group(1).strip()
    unlocked_devices.append(dev)

    # Mount the unlocked device
    print(f"Mounting unlocked device {unlocked_path}")
    mount_proc = run(f"udisksctl mount -b {unlocked_path}", capture_output=True)
    mount_match = re.search(r"at (/.+)", mount_proc.stdout)
    if not mount_match:
        print(f"[!] Could not determine mount point from: {mount_proc.stdout}")
        exit(1)
    mount_path = Path(mount_match.group(1).strip())
    mounted_devices.append(unlocked_path)
    return mount_path


def mount_with_udisks(dev):
    result = run(f"udisksctl mount -b {dev}", capture_output=True)
    match = re.search(r"at (/.+)", result.stdout)
    if not match:
        print(f"[!] Could not determine mount point for {dev}")
        exit(1)
    mount_point = match.group(1).strip()
    mounted_devices.append(dev)
    print(f"{dev} mounted at {mount_point}")
    return Path(mount_point)


def check_drive1_integrity(mount_point):
    print(f"Verifying integrity of drive1 using cshatag")
    run(f"cshatag -q -recursive {mount_point}")


def check_borg_repo(repo_path: Path):
    print(f"Running borg check on {repo_path}")
    run(f"borg check {repo_path}")


def create_borg_backup(repo_path: Path, source_path: Path):
    timestamp = datetime.now().strftime("%Y-%m-%d-%H-%M")
    archive = f"{repo_path}::{timestamp}"
    print(f"Creating borg backup: {archive}")
    run(
        f"borg create -v --stats --progress --compression zstd,6 {archive} {source_path}"
    )


def prune_borg_backup(repo_path: Path):
    print(f"Pruning borg backup: {repo_path}")
    run(f"borg prune --list --keep-last=10 --keep-within=30d {repo_path}")


def sync_to_gdrive(source_path: Path):
    include_file = source_path / "rclone-include.txt"
    if not include_file.exists():
        print(
            f"[!] No rclone-include.txt found at {include_file}. Skipping Google Drive sync."
        )
        exit(1)

    print(f"Syncing files from {source_path} to {GDRIVE_REMOTE} using {include_file}")
    run(
        f"rclone sync {source_path} {GDRIVE_REMOTE} --include-from {include_file} --progress --create-empty-src-dirs"
    )


def cleanup():
    print("\n[+] Cleaning up...")
    time.sleep(1)

    for path in reversed(mounted_devices):
        try:
            print(f"Unmounting {path}")
            run(f"udisksctl unmount -b {path}", check=False)
        except Exception as e:
            print(f"Warning: failed to unmount {path}: {e}")

    for dev in reversed(unlocked_devices):
        try:
            print(f"Locking device {dev}")
            run(f"udisksctl lock -b {dev}", check=False)
        except Exception as e:
            print(f"Warning: failed to lock {dev}: {e}")

    print("[+] Cleanup complete.")


def main():
    # Register for normal exit and Ctrl+C
    atexit.register(cleanup)
    signal.signal(signal.SIGINT, lambda sig, frame: exit(1))

    try:
        drive1_mount = unlock_and_mount_luks(DRIVE1_DEV)
        drive2_mount = mount_with_udisks(DRIVE2_DEV)

        # drive 1
        # check_drive1_integrity(drive1_mount)

        # drive 2
        borg_repo = drive2_mount / BORG_SUBDIR
        check_borg_repo(borg_repo)
        create_borg_backup(borg_repo, drive1_mount)
        prune_borg_backup(borg_repo)

        # drive 3 = gdrive
        sync_to_gdrive(drive1_mount)

        print("\n[+] Backup completed successfully.")

    except subprocess.CalledProcessError as e:
        print(f"\n[-] Command failed:\n{e.stderr if e.stderr else e}")
        exit(1)


if __name__ == "__main__":
    main()
