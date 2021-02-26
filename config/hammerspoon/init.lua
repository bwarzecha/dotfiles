hs.window.animationDuration = 0

local hyper = {"ctrl", "alt", "cmd"}
hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({ up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"}, 
  fullscreen = {hyper, "m"} })

  -- turn off  bluetooth on sleen (lid closed)
function bluetooth(power)
    print("Setting bluetooth to " .. power)
    local cmd = [[blueutil --power ]] .. power
    print("Executing: " .. cmd)
    hs.execute( cmd , true)
end

function caffeineEvents(event)
    print('Received event' ..  event)
    if event == hs.caffeinate.watcher.systemWillSleep then
        bluetooth("off")
    elseif event == hs.caffeinate.watcher.screensDidWake then
        bluetooth("on")
    elseif  event ==  hs.caffeinate.watcher.screensDidUnlock then
    elseif  event ==  hs.caffeinate.watcher.screensDidLock then
    elseif  event ==  hs.caffeinate.watcher.screensaverDidStart then
    elseif  event ==  hs.caffeinate.watcher.screensaverDidStop then
    end
end

watcher = hs.caffeinate.watcher.new(caffeineEvents)
watcher:start()
