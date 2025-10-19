local mp = require 'mp'

local function notify(summary, body, urgency)
  local args = {"notify-send", "-a", "mpv"}
  if urgency then
    table.insert(args, "-u")
    table.insert(args, urgency)
  end
  table.insert(args, summary)
  if body then table.insert(args, body) end

  mp.command_native_async({
    name = "subprocess",
    playback_only = false,
    args = args
  })
end

local loaded = false

mp.register_event("start-file", function()
  loaded = false
  local path = mp.get_property("path") or "(unknown)"
  notify("loading…", path)
end)

mp.register_event("file-loaded", function()
  loaded = true
  local title = mp.get_property("media-title") or mp.get_property("path") or "(unknown)"
  notify("video loaded", title)
end)

mp.register_event("end-file", function(e)
  if not loaded then
    local path = mp.get_property("path") or "(unknown)"
    local err  = (e and e.error) or "load failed"
    notify("failed to load", path .. " (" .. err .. ")", "critical")
  end
end)
