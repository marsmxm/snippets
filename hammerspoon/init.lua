local log = hs.logger.new('my-logger','debug')

hs.hotkey.bind({"alt"}, "Space", function()
    wez = hs.application.get("Wezterm")
    if wez then
       if wez:isFrontmost() then
          wez:hide()
       else
          wez:activate()
       end
    else
       hs.application.launchOrFocus("Wezterm")
    end
end)

hs.loadSpoon("Caffeine")

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
      spoon.Caffeine:start()
end)

-- hs.hotkey.bind({"fn"}, "S", function()
--       hs.spotify.displayCurrentTrack()
-- end