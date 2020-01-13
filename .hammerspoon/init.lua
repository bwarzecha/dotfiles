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
log_event_file = os.getenv("HOME") .. "/.logs/apps/" .. hostname:gsub(" ","_") .. "_history" 

hs.loadSpoon("MiroWindowsManager")
spoon.MiroWindowsManager:bindHotkeys({ up = {hyper, "k"},
  right = {hyper, "l"},
  down = {hyper, "j"},
  left = {hyper, "h"},
  fullscreen = {hyper, "m"} })

-- hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'L', function() hs.caffeinate.startScreensaver() end)

events_buffer = {}
events_buffer.length = 0


function log_event(name, details)
    event = {
        timestamp = os.date("%x %X", os.time()),
        name = name,
        details = details or {}
    }
    table.insert(events_buffer, event)
    events_buffer.length = events_buffer.length + 1
end


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
        log_event('system_will_sleep')
        bluetooth("off")
        flush_events()
    elseif event == hs.caffeinate.watcher.screensDidWake then
        log_event('screen_did_wake')
        bluetooth("on")
    elseif  event ==  hs.caffeinate.watcher.screensDidUnlock then
        log_event('screen_did_unlock')
    elseif  event ==  hs.caffeinate.watcher.screensDidLock then
        log_event('screen_did_lock')
    elseif  event ==  hs.caffeinate.watcher.screensaverDidStart then
        log_event('screensaver_did_start')
    elseif  event ==  hs.caffeinate.watcher.screensaverDidStop then
        log_event('screensaver_did_stop')
    end
end


function encode_event(event)
    local lines = {}
    table.insert(lines, event.timestamp .. " " .. event.name)
    for i, v in pairs(event.details) do
        table.insert(lines, "\t:" .. i .. ":\t" .. v )
    end
    return table.concat(lines, "\n")
end

function flush_events() 
  local this_file,err = io.open(log_event_file, "a")
  if this_file==nil then
    print("Couldn't open file: "..err)
  end
  for i, event in ipairs(events_buffer) do 
    this_file:write(encode_event(event) .. "\n")
  end
  this_file:close() 
  events_buffer = {}
  events_buffer.length = 0
end 

prev_msg = ""
prev_timestamp = os.date("%x %X", os.time())
prev_time = os.time()
prev_details = nil 
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
        -- print('Running personal laptop script')
        _, message,_ = hs.osascript.applescript(script_personal)
    else 
        -- print('Running work laptop script')
        _, message,_ = hs.osascript.applescript(script)
    end
    if message ~= nil then 
        msg_str = table.concat(message, "\n")
        if prev_msg ~= msg_str then 
            if prev_details ~= nil then
                prev_details.durationSeconds = os.difftime(os.time(),prev_time)
                log_event("application_changed", prev_details)
            end
            prev_details = { 
                activeAppName = message[1],
                windowName = message[2],
                url = message[3],
                title = message[4],
                start = timestamp,
            }
            -- hs.alert.show(os.date("%x %X", os.time()) .. ":\n" .. table.concat(message, "\n"))
            prev_msg = msg_str
            prev_timestamp = os.date("%x %X", os.time())
            prev_time = os.time()
        end
    end
end

logger_timer =  hs.timer.new(1, get_active_app)
flush_timer = hs.timer.new(60, flush_events) -- Every 5 minutes
logger_timer:start()
flush_timer:start()
get_active_app()

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'T', function() flush_events();  end)


watcher = hs.caffeinate.watcher.new(caffeineEvents)
watcher:start()
