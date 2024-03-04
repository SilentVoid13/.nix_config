local M = {}

local iter = require("obsidian.itertools").iter
local search = require("obsidian.search")
local util = require("obsidian.util")
local client = require("obsidian").get_client()

M.follow_closest_link = function()
	local current_line = vim.api.nvim_get_current_line()
	local _, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	cur_col = cur_col + 1 -- nvim_win_get_cursor returns 0-indexed column

	local best_match = nil
	for match in iter(search.find_refs(current_line, { include_naked_urls = true, include_file_urls = true })) do
		local open, close, _ = unpack(match)
		if
			best_match == nil
			or math.abs(cur_col - open) < math.abs(cur_col - best_match[2])
			or math.abs(cur_col - close) < math.abs(cur_col - best_match[1])
		then
			best_match = match
		end
	end
	if best_match == nil then
		return nil
	end
	local link = current_line:sub(best_match[1], best_match[2])
	client:follow_link_async(link, nil)
end

M.create_new_note = function()
	local note_name = vim.fn.input({
		prompt = "Enter note name: ",
	})
	if string.len(note_name) == 0 then
		return
	end
	local id = tostring(os.time())
	local aliases = { note_name }
	local note_title = note_name .. " - " .. id
	local note = client:create_note({ id = note_title, aliases = aliases })
	local cur_note = client:current_note()

	-- Prevents empty line after frontmatter
	note.has_frontmatter = true
	note:add_tag("knowledge/state/seedling")
	note:add_field("source", { string.format("[[%s]]", cur_note.id) })
	note:add_field("related", {})

	-- Prevents id field in frontmatter
	local fm = note:frontmatter()
	fm["id"] = nil

	note:save({
		frontmatter = fm,
		update_content = function()
			return "- \n\n## Resources\n- "
		end,
	})

	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. string.format(" [[%s]]", note_title) .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
	vim.api.nvim_command("write")

	client:update_ui(0)
	client:open_note(note)
end

return M
