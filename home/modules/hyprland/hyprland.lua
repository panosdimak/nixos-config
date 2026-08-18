-- Hyprland config (Lua).
--
-- Home Manager appends this file to the generated ~/.config/hypr/hyprland.lua,
-- after the parts it renders from Nix: monitors, env, devices and the
-- `autostart` list, plus the systemd session hook. Everything below is the
-- imperative half — binds, rules, animations — which reads better as Lua.

--------------------------------------------------------------------- programs
local terminal = "kitty"
local fileManager = "nautilus"
local browser = "zen-twilight"

--------------------------------------------------------------------- colors
-- Rendered by matugen to ~/.config/hypr/colors.lua on wallpaper change.
-- dofile re-reads on each reload; fall back to defaults if it's missing.
local ok, colors = pcall(dofile, os.getenv("HOME") .. "/.config/hypr/colors.lua")
if not ok or type(colors) ~= "table" then
  colors = {
    active_border = "rgba(aad291ff)",
    inactive_border = "rgba(8d928680)",
  }
end

--------------------------------------------------------------------- autostart
-- hyprland.start fires once at launch (not on reload), so this behaves like the
-- old exec-once. `autostart` is the Nix-side list; Home Manager registers its
-- own start hook before this one, so the session target is already up.
hl.on("hyprland.start", function()
  for _, command in ipairs(autostart or {}) do
    hl.exec_cmd(command)
  end
end)

--------------------------------------------------------------------- look & feel
hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 8,
    border_size = 0,
    float_gaps = -1, -- floating windows inherit tiled gaps
    resize_on_border = false,
    allow_tearing = false,
    layout = "dwindle",
    -- Snap floating windows to each other and monitor edges
    snap = {
      enabled = true,
      window_gap = 10,
      monitor_gap = 10,
    },
    col = {
      active_border = colors.active_border,
      inactive_border = colors.inactive_border,
    },
  },

  decoration = {
    rounding = 4,
    rounding_power = 4,
    active_opacity = 1.0,
    inactive_opacity = 0.95,
    shadow = {
      enabled = true,
      range = 6,
      render_power = 2,
    },
    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      noise = 0,
      contrast = 2,
      vibrancy = 0.5,
      brightness = 0.8,
      -- Blur right-click menus/popups against the app beneath them.
      -- ignorealpha skips the menu's transparent drop-shadow margin so the
      -- blur doesn't bleed into a halo border (popover bg alpha is 0.85).
      popups = true,
      popups_ignorealpha = 0.6,
    },
  },

  animations = { enabled = true },

  dwindle = { preserve_split = true },
  master = { new_status = "master" },

  misc = {
    force_default_wallpaper = 0, -- plain background, no anime
    disable_hyprland_logo = true,
    disable_splash_rendering = true, -- no splash text in the gap before DMS draws
    middle_click_paste = false,
    focus_on_activate = true,
    vrr = 1, -- variable refresh rate (FreeSync/G-Sync) on supported monitors
  },

  -- Don't bitmap-magnify XWayland surfaces on fractionally-scaled monitors.
  -- No-op on the desktop (HDMI-A-1 is scale 1); needed on the laptop's eDP-1.
  xwayland = { force_zero_scaling = true },

  binds = {
    workspace_center_on = 1, -- center cursor on focused window on switch
  },

  cursor = {
    persistent_warps = true,
    hide_on_key_press = true,
    warp_on_change_workspace = 1,
    inactive_timeout = 5,
  },

  render = {
    direct_scanout = 1, -- allow direct scanout for fullscreen apps
  },

  input = {
    kb_layout = "us,gr",
    kb_variant = "",
    kb_model = "",
    kb_options = "grp:win_space_toggle",
    kb_rules = "",
    numlock_by_default = true,
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.25,
    },
  },
})

--------------------------------------------------------------------- animations
hl.curve("modern", { type = "bezier", points = { { 0.55, 0.12 }, { 0, 0.93 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.1, 0.9 }, { 0.1, 1 } } })
hl.curve("layers", { type = "bezier", points = { { 0.32, 0.5 }, { 0.05, 0.97 } } })
hl.curve("rubber", { type = "spring", mass = 1, stiffness = 90, dampening = 10 })

-- windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "snappy", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "snappy", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "snappy", style = "slide" })

-- layers
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "layers", style = "fade" })

-- fade
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "layers" })

-- border (unused)
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "modern" })

-- workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "snappy", style = "slidefade" })
-- special workspace toggle (SUPER+Z)
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "snappy", style = "slidefadevert" })
-- fade when monitors turn on/off via DPMS
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 5, bezier = "modern" })

--------------------------------------------------------------------- keybinds
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl kill")) -- click-to-kill a frozen window
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("vicinae vicinae://toggle"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + D", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("dms ipc lock lock"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(mainMod .. " + C", hl.dsp.window.center()) -- center focused floating window
hl.bind(mainMod .. " + R", hl.dsp.submap("resize")) -- enter resize mode

-- Focus movement
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Swap windows
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))

-- Workspaces 1-10 (switch + move active window)
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Overview (standalone quickshell-overview)
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

-- Next / prev workspace
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "r-1" }))

-- New empty workspace
hl.bind(mainMod .. " + N", hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.window.move({ workspace = "empty" }))

-- Special workspace
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Power menu & tools
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))
-- Screenshots (hyprshot; -z freezes the screen while selecting).
-- A region shot only goes to the clipboard — S then D keeps it, S then E
-- annotates it. D and E read the clipboard, so they work on any copied image,
-- not just the last shot. HYPRSHOT_DIR comes from the Nix env block.
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -z --clipboard-only"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd([[f="$HYPRSHOT_DIR/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"; mkdir -p "$HYPRSHOT_DIR" && wl-paste -t image/png > "$f" && notify-send -a Hyprshot -i "$f" "Screenshot saved" "$f" || rm -f "$f"]]))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("wl-paste -t image/png | swappy -f -"))
-- Whole screen, saved and copied (no -z: nothing to select, so nothing to freeze)
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active"))
-- OCR a region to the clipboard (--raw, not -r: hyprshot declares -r as taking an
-- argument, so getopt drops it and you get a plain screenshot instead)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprshot -m region -z --raw | tesseract - - -l eng+ell | wl-copy"))

-- Mouse binds: move / resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media & brightness (locked so they work on the lockscreen; repeat on hold)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------------------------------------------- resize submap
hl.define_submap("resize", function()
  hl.bind("right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
end)

--------------------------------------------------------------------- window rules
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

-- Center floating XWayland dialogs (REAPER/OnlyOffice confirm dialogs that
-- otherwise spawn top-left). modal excludes dropdown/popup menus.
hl.window_rule({
  match = { class = ".*", xwayland = true, float = true, modal = true },
  center = true,
})

-- Prevent idle/lock while watching media (always for mpv, fullscreen-only for browsers)
hl.window_rule({ match = { class = "mpv" }, idle_inhibit = "always" })
hl.window_rule({ match = { class = "firefox" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { class = "zen" }, idle_inhibit = "fullscreen" })

-- Float, pin, and park picture-in-picture windows bottom-right
hl.window_rule({
  match = { title = "(Picture-in-Picture)" },
  float = true,
  pin = true,
  size = { 480, 270 },
  move = { "monitor_w-490", "monitor_h-280" },
})

-- Preserve aspect ratio when resizing media windows
hl.window_rule({ match = { class = "mpv" }, keep_aspect_ratio = true })

-- Mark game windows for VRR/tearing
hl.window_rule({ match = { class = "steam_app_.*" }, content = "game" })
hl.window_rule({ match = { class = "steam_app_.*" }, immediate = true })

-- Vesktop (Electron) declares its surface opaque once focused, so Hyprland stops
-- blurring behind it. Forcing opacity just below 1 makes Hyprland blend and
-- re-apply blur regardless of the opaque-region hint.
hl.window_rule({ match = { class = "vesktop" }, opacity = "0.99 override 0.99 override" })

--------------------------------------------------------------------- layer rules
hl.layer_rule({ match = { namespace = "launcher" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "vicinae-blur", match = { namespace = "vicinae" }, blur = true, ignore_alpha = 0 })

--------------------------------------------------------------------- gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down", action = "close" })
hl.gesture({ fingers = 2, direction = "pinch", mods = "SUPER", action = "resize" })
hl.gesture({ fingers = 3, direction = "right", mods = "SUPER", action = function()
  hl.dispatch(hl.dsp.window.move({ workspace = "r-1" }))
end })
hl.gesture({ fingers = 3, direction = "left", mods = "SUPER", action = function()
  hl.dispatch(hl.dsp.window.move({ workspace = "r+1" }))
end })

--------------------------------------------------------------------- workspace rules
hl.workspace_rule({ workspace = "special:magic", gaps_out = 30 })
