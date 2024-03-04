local M = {}

M.follow_closest_link = function()
	local iter = require("obsidian.itertools").iter
	local search = require("obsidian.search")

	local current_line = vim.api.nvim_get_current_line()
	local _, cur_col = unpack(vim.api.nvim_win_get_cursor(0))
	cur_col = cur_col + 1 -- nvim_win_get_cursor returns 0-indexed column

	local best_match = nil
	for match in
		iter(
			search.find_refs(
				current_line,
				{ include_naked_urls = true, include_file_urls = true }
			)
		)
	do
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
	local client = require("obsidian").get_client()
	client:follow_link_async(link, nil)
end

return M
