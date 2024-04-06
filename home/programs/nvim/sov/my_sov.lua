local M = {}

local sov = require("sov")

M.new_note = function()
	local note_name = vim.fn.input({
		prompt = "Enter note name: ",
	})
	if string.len(note_name) == 0 then
		return
	end
	local id = os.date("%Y%m%d%H%M")
	local filename = note_name .. " - " .. id

	-- get current filename
	local cur_file = vim.fn.expand("%:t:r")

	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. string.format(" [[%s]]", filename) .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
	vim.api.nvim_command("write")

	local new_path = sov.script_create(filename, "new_note.py", { cur_file, filename })
	vim.api.nvim_command("e " .. new_path)
end

return M
