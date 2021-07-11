local M = {}

M.config = function()
  require('bufferline').setup{
    options = {
      view = "default",
      numbers = "none",
      buffer_close_icon= '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is deduplicated
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, _, _)
        return " ("..count..")"
      end,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      always_show_bufferline = true,
    }
  }
end

return M
