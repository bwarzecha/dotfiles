-- init grid
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 7
hs.grid.GRIDHEIGHT = 3

-- disable animation
hs.window.animationDuration = 0

local hyper = {"ctrl", "alt", "cmd"}
hostname = hs.host.localizedName()
isPersonal = string.match(hostname, "Bartosz") ~= nil
log_event_file = os.getenv("HOME") .. "/notes/personal/log.txt" 

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
    hs.execute([["blueutil" "--power "  "power"]], true)
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
    hs.execute([["python3.7" "~/dotfiles/web_blocker/blocker.py"  "/etc/hosts" "--block-all" "~/dotfiles/web_blocker/websites.txt"]], true)
    hs.alert.show("Websites Blocked")
end

function unblock_sites()
    hs.execute([["python3.7" "~/dotfiles/web_blocker/blocker.py"  "/etc/hosts" "--unblock-all" "~/dotfiles/web_blocker/websites.txt"]], true)
    hs.alert.show("Websites Unblocked")
end

function log_event(event) 
    local this_file , line
    line = event
    this_file = io.open(log_event_file, "a") 
    this_file:write(line) 
    this_file:close() 
end 

prev_msg = ""
function get_active_app()
    local script = [[
tell application "System Events"
    set activeApp to first application process whose frontmost is true
    set appWindow to the value of attribute "AXFocusedWindow" of activeApp
    set activeAppName to name of the activeApp
    set windowName to name of appWindow
end tell

set myURL to ""
set myTitle to ""
set nameOfActiveApp to (path to frontmost application as text)
if "Safari" is in nameOfActiveApp then
    tell application "Safari"
        set myURL to the URL of the current tab of the front window
        set myTitle to the name of the current tab of the front window
    end tell
else if "Chrome" is in nameOfActiveApp then
    tell application "Google Chrome"
        set myURL to the URL of the active tab of the front window
        set myTitle to the title of the active tab of the front window
    end tell
end if
return {activeAppName, windowName, myUrl, myTitle}
    ]]
    local script_personal = [[
tell application "System Events"
    set activeApp to first application process whose frontmost is true
    set appWindow to the value of attribute "AXFocusedWindow" of activeApp
    set activeAppName to name of the activeApp
    set windowName to name of appWindow
end tell

set myURL to ""
set myTitle to ""
set nameOfActiveApp to (path to frontmost application as text)
if "Safari" is in nameOfActiveApp then
    tell application "Safari"
        set myURL to the URL of the current tab of the front window
        set myTitle to the name of the current tab of the front window
    end tell
end if
return {activeAppName, windowName, myUrl, myTitle}
    ]]
    if isPersonal then
        print('Running personal laptop script')
        _, message,_ = hs.osascript.applescript(script_personal)
    else 
        print('Running work laptop script')
        _, message,_ = hs.osascript.applescript(script)
    end

    msg_str = table.concat(message, "\n")
    if prev_msg ~= msg_str then 
        log_event(os.date("%x %X", os.time()) .. " - " .. table.concat(message, ",") .. "\n")
        hs.alert.show(os.date("%x %X", os.time()) .. ":\n" .. table.concat(message, "\n"))
        prev_msg = msg_str
    end
    return message
end

hs.timer.doEvery(5, get_active_app)
    

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'T', function() get_active_app();  end)

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'B', function() block_sites() end)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'U', function() unblock_sites() end)


watcher = hs.caffeinate.watcher.new(f)
watcher:start()
