-- Treesitter-based structural motion: jump to the next/previous sibling node,
-- surfacing to the enclosing construct when a level is exhausted.
local M = {}

local function move_to(node)
  local row, col = node:start()
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

-- vim.treesitter.get_node() returns whatever tree currently exists, which can be
-- stale or missing right after a move; parse explicitly so sibling/parent links
-- always match the current buffer.
local function node_at_cursor()
  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if not ok or not parser then return nil end
  local tree = parser:parse()[1]
  if not tree then return nil end
  local cur = vim.api.nvim_win_get_cursor(0)
  return tree:root():named_descendant_for_range(cur[1] - 1, cur[2], cur[1] - 1, cur[2])
end

-- A wrapper node (Lua `block`, `chunk`, ...) starts where its first child does,
-- so landing on it just looks like jumping to that child. Treat such nodes as
-- transparent and skip past them when ascending.
local function is_transparent(node)
  local child = node:named_child(0)
  if not child then return false end
  local nrow, ncol = node:start()
  local crow, ccol = child:start()
  return nrow == crow and ncol == ccol
end

-- Move to the next/previous named sibling. With no sibling in that direction,
-- ascend toward the enclosing construct -- but a transparent wrapper that has a
-- sibling at its own indentation (e.g. Python's `decorated_definition`, whose
-- siblings are the other methods) is a real peer: step to that sibling instead
-- of skipping past it. A non-aligned sibling (e.g. a function's `parameters`
-- relative to its body) is ignored, so we land on the enclosing construct.
local function goto_sibling(dir)
  local node = node_at_cursor()
  if not node then return end
  local target
  if dir == "next" then
    target = node:next_named_sibling()
  else
    target = node:prev_named_sibling()
  end
  if not target then
    local parent = node:parent()
    while parent do
      if not is_transparent(parent) then
        target = parent -- enclosing construct (function, class, if, ...)
        break
      end
      local sib
      if dir == "next" then
        sib = parent:next_named_sibling()
      else
        sib = parent:prev_named_sibling()
      end
      if sib then
        local _, pcol = parent:start()
        local _, scol = sib:start()
        if scol == pcol then -- aligned peer, e.g. the next decorated method
          target = sib
          break
        end
      end
      parent = parent:parent()
    end
  end
  if target then move_to(target) end
end

function M.next() goto_sibling("next") end
function M.prev() goto_sibling("prev") end

return M
