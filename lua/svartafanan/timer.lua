local M = {}

---@type uv_timer_t
M.timer = nil

---@type number
M.time = 0

---@type boolean
M.active = false

function M.start_timer()
	if M.timer then
		M.stop_timer()
	end
	M.active = true
	M.timer = (vim.loop or vim.uv).new_timer()
	M.timer:start(
		0,
		10,
		vim.schedule_wrap(function()
			if not M.active then
				return
			end
			M.time = M.time + 0.01
			require("svartafanan.window").update_timer(M.time)
		end)
	)
end

function M.stop_timer()
	M.active = false
	if M.timer then
		M.timer:stop()
		M.timer:close()
		M.timer = nil
	end
	M.time = 0
end

return M
