--- A small star catalogue used to exercise Lua highlighting.
-- @module starfield
local M = {}

local MAX_MAGNITUDE = 6.5
local ratio = 0x1F / 3.25e2
local verbose = false

-- TODO: load the catalogue from disk instead of hardcoding it
-- NOTE: magnitudes are apparent, not absolute
-- FIX: Sirius has a negative magnitude and sorts wrong
local stars = {
  { name = "Sirius", magnitude = -1.46, colour = "white" },
  { name = "Vega", magnitude = 0.03, colour = "blue\twhite" },
  { name = "Antares", magnitude = 1.06, colour = "red" },
}

---@class Orb
---@field name string
---@field radius number
local Orb = {}
Orb.__index = Orb

--- Create a new orb.
---@param name string
---@param radius number
---@return Orb
function Orb.new(name, radius)
  local self = setmetatable({}, Orb)
  self.name = name
  self.radius = radius or 1
  return self
end

function Orb:describe()
  return string.format("%s (r=%.2f)\n", self.name, self.radius)
end

function M.visible(list)
  local out = {}
  for _, star in ipairs(list) do
    if star.magnitude <= MAX_MAGNITUDE and not star.hidden then
      table.insert(out, star.name:upper())
    elseif verbose == true then
      print("skipped: " .. tostring(star.name))
    end
  end
  return out
end

local function slug(text)
  return (text:gsub("%s+", "-"):lower())
end

M.Orb = Orb
M.slug = slug
M.ratio = ratio
M.stars = stars

return M
