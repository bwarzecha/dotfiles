hs.window.animationDuration = 0

local hyper = {"ctrl", "alt", "cmd"}
hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({ up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"}, 
  fullscreen = {hyper, "m"} })