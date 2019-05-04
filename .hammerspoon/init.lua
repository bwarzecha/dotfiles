-- init grid
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 7
hs.grid.GRIDHEIGHT = 3

-- disable animation
hs.window.animationDuration = 0

local hyper = {"ctrl", "alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({ up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "m"} })

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'L', function() hs.caffeinate.startScreensaver() end)

-- turn off  bluetooth on sleen (lid closed)
function bluetooth(power)
    print("Setting bluetooth to " .. power)
    output, status, type, rc  = hs.execute("blueutil --power " .. power, true)

		if rc ~= 0 then
        print("Unexpected result executing `blueutil`: rc=" .. rc .. " type=" .. type .. " output=" .. output)
    end
end

function f(event)
		print('Received event' ..  event)
    if event == hs.caffeinate.watcher.systemWillSleep then
        bluetooth("off")
    elseif event == hs.caffeinate.watcher.screensDidWake then
        bluetooth("on")
    end
end

function block_sites()
    hs.execute("python3.7 ~/dotfiles/web_blocker/blocker.py /etc/hosts --block-all ~/dotfiles/web_blocker/websites.txt", true)
    hs.alert.show("Websites Blocked")
end

function unblock_sites()
    hs.execute("python3.7 ~/dotfiles/web_blocker/blocker.py /etc/hosts --unblock-all ~/dotfiles/web_blocker/websites.txt", true)
  
    hs.alert.show("Websites unblocked")
end

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'B', function() block_sites() end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'U', function() unblock_sites() end)


watcher = hs.caffeinate.watcher.new(f)
watcher:start()
