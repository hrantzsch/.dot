M = {}

---Parse date from git blame line and return the age in days
---
---@param blame_line string
---@return integer?
---@nodiscard
local function GetCommitAge(blame_line)
  local year, month, day = blame_line:match("(%d+)%-(%d+)%-(%d+)")
  if year and month and day then
    local commit_date = os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })
    return os.difftime(os.time(), commit_date) / (24 * 60 * 60) -- seconds to days
  else
    return nil
  end
end

-- Neovim color value to RGB
local function color_to_rgb(color)
  local r = (color / 0x10000) % 0x100
  local g = (color / 0x100) % 0x100
  local b = color % 0x100
  return r, g, b
end

local function interpolate_color(color1, color2, fraction)
  local r1, g1, b1 = color_to_rgb(color1)
  local r2, g2, b2 = color_to_rgb(color2)

  local r = r1 + (r2 - r1) * fraction
  local g = g1 + (g2 - g1) * fraction
  local b = b1 + (b2 - b1) * fraction

  return string.format("#%02x%02x%02x", r, g, b)
end

local function HighlightBlame()
  local normal_color = vim.api.nvim_get_hl_by_name("Normal", true).foreground
  local error_color = vim.api.nvim_get_hl_by_name("ErrorMsg", true).foreground

  local n_lines = vim.api.nvim_buf_line_count(0)
  for i = 1, n_lines do
    local age = GetCommitAge(vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1])

    if age then
      -- local log_age = math.log(age + 1) / math.log(365 + 1)
      local fraction = math.min(age / 365, 1) -- Age as a fraction of a year
      local interpolated_color = interpolate_color(error_color, normal_color, fraction)

      local group_name = "BlameLine" .. i
      vim.api.nvim_command('highlight ' .. group_name .. ' guifg=' .. interpolated_color)
      vim.api.nvim_buf_add_highlight(0, -1, group_name, i - 1, 0, -1)
    end
  end
end

function M.GitBlameHeat()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_command('vsplit new')
  vim.api.nvim_command('setlocal buftype=nofile nobuflisted')
  vim.api.nvim_command('r!git blame ' .. current_file)
  vim.api.nvim_command('1d')
  vim.api.nvim_command('' .. current_line)
  HighlightBlame()
end

return M
