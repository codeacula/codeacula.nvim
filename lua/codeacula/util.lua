local M = {}

local function channels(hex)
  return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

---Mix `fg` over `bg`. `alpha` is the weight of `fg`, 0..1.
function M.blend(fg, bg, alpha)
  local fr, fgr, fb = channels(fg)
  local br, bgr, bb = channels(bg)
  local function mix(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(fr, br), mix(fgr, bgr), mix(fb, bb))
end

local function linear(v)
  v = v / 255
  return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4
end

function M.luminance(hex)
  local r, g, b = channels(hex)
  return 0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b)
end

---WCAG 2 contrast ratio between two colours.
function M.contrast(a, b)
  local la, lb = M.luminance(a), M.luminance(b)
  if la < lb then
    la, lb = lb, la
  end
  return (la + 0.05) / (lb + 0.05)
end

return M
