# 🔨 Hammerspoon Configuration

A powerful macOS automation setup that enhances productivity through custom keyboard shortcuts, application management, and intelligent text processing.

## 🚀 Features Overview

### 📱 Application Management
- **Quick App Switching**: Seamlessly switch between applications and windows
- **Window Management**: Move and focus windows across multiple screens
- **Smart Focus**: Intelligent window focusing with fallback options

### ⌨️ Enhanced Keyboard Shortcuts
- **Greek Letters**: Convert Latin letters to Greek symbols with a simple trigger
- **Chrome DevTools**: Quick toggle for Chrome Developer Tools
- **Custom Hotkeys**: Personalized shortcuts for common workflows

### 🌐 Browser Automation
- **Page Summarization**: Automated Chrome page content summarization
- **URL Management**: Copy, navigate, and process web content automatically
- **Multi-browser Support**: Works with Chrome, Brave, and Edge

### 🖥️ Terminal Integration
- **Warp Terminal**: Enhanced terminal window management
- **Quick Terminal Access**: Fast switching between terminal sessions

---

## 📋 Detailed Features

### 🔤 Greek Letters Converter
Transform Latin letters into Greek symbols using an intuitive trigger system.

**Usage**: Type any Latin letter followed by `∆` (delta symbol)

**Examples**:
- `a∆` → `Α` (Alpha)
- `b∆` → `Β` (Beta) 
- `g∆` → `Γ` (Gamma)
- `d∆` → `Δ` (Delta)
- `p∆` → `Π` (Pi)
- `f∆` → `Φ` (Phi)
- `o∆` → `Ω` (Omega)

**Complete Mapping**:
```
a→Α  b→Β  g→Γ  d→Δ  e→Ε  z→Ζ  h→Η  q→Θ  v→Ψ  k→Κ
l→Λ  m→Μ  n→Ν  x→Ξ  p→Π  r→Ρ  s→Σ  t→Τ  f→Φ  y→Ψ  o→Ω
```

### 🌐 Chrome Integration

#### DevTools Toggle
- **Shortcut**: `ù` key (Italian keyboard layout)
- **Action**: Toggles Chrome Developer Tools (`Cmd+Alt+J`)
- **Compatibility**: Works with Chrome, Brave, and Edge

#### Page Summarization Workflow
- **Shortcut**: `Cmd+-`
- **Automated Sequence**:
  1. Opens Chrome History (`Cmd+Y`)
  2. Focuses address bar (`Cmd+L`)
  3. Copies current URL (`Cmd+C`)
  4. Opens Chrome settings (`Cmd+,`)
  5. Opens new tab (`Cmd+N`)
  6. Pastes URL and adds summarization prompt
  7. Executes the request

### 🖥️ Application Shortcuts

#### Cursor Editor Management
- **Focus Cursor**: `Alt+Escape`
  - Focuses on Cursor editor window
  - Handles multiple window scenarios
  - Moves windows to primary screen when needed

#### Warp Terminal Management  
- **Switch Terminal**: `Cmd+Escape`
  - Cycles through Warp terminal windows
  - Focuses on secondary window if multiple exist
  - Launches Warp if not running

### 🛠️ Advanced Cursor Integration

#### Prompt Automation
```lua
write_prompt_in_cursor_instance({
    prompt = "Your AI prompt here",
    window_title = "Specific window title"
})
```

#### Background Agent Integration
```lua
write_prompt_in_cursor_instance_for_background_agent({
    window_title = "Target window",
    prompt = "Background task prompt",
    open_cloud_modal = true
})
```

### 🎯 Utility Functions

#### Smart Window Focusing
```lua
focus_app_window({
    app_name = "Application Name",
    window_title = "Window Title Pattern",
    print_info = false  -- Debug information
})
```

---

## 🔧 Installation & Setup

### Prerequisites
1. **Hammerspoon**: Download from [hammerspoon.org](https://www.hammerspoon.org/)
2. **Accessibility Permissions**: Required for key event capture
3. **Applications**: Cursor, Warp, Chrome (optional: Brave, Edge)

### Configuration Steps

1. **Clone/Copy Configuration**:
   ```bash
   # Copy files to Hammerspoon directory
   cp -r * ~/.hammerspoon/
   ```

2. **Enable Accessibility**:
   - Go to `System Preferences > Privacy & Security > Accessibility`
   - Add and enable Hammerspoon

3. **Reload Configuration**:
   - Press `Cmd+Space` and type "Hammerspoon"
   - Click "Reload Config" or use the menu bar icon

### File Structure
```
~/.hammerspoon/
├── init.lua                    # Main configuration entry
├── keybindings.lua            # Keyboard shortcut definitions
├── Spoons/
│   ├── chrome_hotkeys.lua     # Chrome developer tools
│   ├── cursor.lua             # Cursor editor integration
│   ├── keys_substitutions.lua # Greek letters converter
│   ├── resume_chrome_page.lua # Page summarization
│   └── warp.lua              # Terminal management
├── utils/
│   └── apps_utils.lua        # Application utilities
└── templates/
    └── interactive_modal.lua  # Modal interface template
```

---

## ⌨️ Complete Keyboard Shortcuts

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Alt+Escape` | Focus Cursor | Switch to Cursor editor |
| `Cmd+Escape` | Switch Terminal | Cycle Warp terminal windows |
| `ù` | Chrome DevTools | Toggle developer tools |
| `Cmd+-` | Summarize Page | Automated page summarization |
| `[letter]∆` | Greek Letter | Convert to Greek symbol |

---

## 🔄 Advanced Usage

### Custom Hotkey Creation
```lua
hs.hotkey.bind({"cmd", "alt"}, "key", function()
    -- Your custom action here
end)
```

### Application Detection
```lua
local app = hs.application.find("AppName")
if app and app:bundleID() == "com.example.app" then
    -- App-specific actions
end
```

### Window Management
```lua
local windows = app:allWindows()
for _, window in ipairs(windows) do
    window:moveToScreen(targetScreen)
    window:focus()
end
```

---

## 🐛 Troubleshooting

### Common Issues

**Greek Letters Not Working**:
- Verify Accessibility permissions
- Check Hammerspoon console for errors
- Ensure `∆` symbol is correctly typed

**Application Focus Issues**:
- Confirm application names match exactly
- Check if applications are running
- Verify window titles for specific targeting

**Chrome Integration Problems**:
- Ensure Chrome is the frontmost application
- Check bundle ID compatibility
- Verify keyboard layout for `ù` key

### Debug Mode
Enable debug output by uncommenting print statements in the respective Spoon files.

---

## 🤝 Contributing

Feel free to extend this configuration with additional Spoons and functionality. The modular structure makes it easy to add new features without affecting existing ones.

### Adding New Spoons
1. Create new `.lua` file in `Spoons/` directory
2. Add `require("Spoons.filename")` to `keybindings.lua`
3. Follow the existing pattern for hotkey binding

---

## 📄 License

This configuration is provided as-is for personal use and modification.

---

*Made with ❤️ for enhanced macOS productivity*
