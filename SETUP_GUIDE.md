-- Setup Guide for MegaGYM in Roblox Studio

## Installation Steps

### 1. Create Workspace Structure

In Roblox Studio Workspace, create the following folders:
- **BoxingRing** (Part folder with PunchTargets)
- **Treadmills** (Folder containing multiple treadmill models)
- **WeightMachines** (Folder containing multiple weight machine models)
- **AmbientMusic** (Part for audio)

### 2. Add Server Scripts

1. In **ServerScriptService**:
   - Create a ModuleScript named `config` - Copy contents from `src/shared/config.lua`
   - Create a ModuleScript named `main` - Copy contents from `src/server/main.lua`
   - Create folder `equipment` and add:
     - ModuleScript `boxing_ring.lua`
     - ModuleScript `treadmill.lua`
     - ModuleScript `weight_machine.lua`
   - Create folder `player` and add:
     - ModuleScript `player_manager.lua`

### 3. Add Client Scripts

1. In **StarterPlayer > StarterCharacterScripts**:
   - Create a ModuleScript named `config` - Copy contents from `src/shared/config.lua`

2. In **StarterPlayer > StarterPlayerScripts**:
   - Create a LocalScript named `ui_init` - Copy contents from `src/client/main.lua`
   - Create folder `ui` and add:
     - ModuleScript `gym_ui.lua`

### 4. Build Gym Models

Create models in Workspace:

#### Boxing Ring Setup
```
BoxingRing (Model)
├── Ring (Part)
├── PunchTarget (Part) x4 - Corners
├── Ropes (Part) x4
└── Canvas (Part)
```

#### Treadmill Setup
```
Treadmill (Model)
├── Base (Part)
├── TouchZone (Part) - For player detection
├── Display (ScreenGui)
│   └── Speed (TextLabel)
└── Motor (Part)
```

#### Weight Machine Setup
```
WeightMachine (Model)
├── Base (Part)
├── InteractZone (Part) - For player detection
├── Display (ScreenGui)
│   └── Info (TextLabel)
├── Weight (Part) x3
└── Handles (Part) x2
```

### 5. Configure Equipment Properties

**For Treadmills & Weight Machines:**
- Set `CanCollide = false` on interactive parts
- Set `CanTouch = true` on TouchZone/InteractZone
- Add Humanoid detector logic

**For Boxing Ring:**
- Set up PunchTargets with Touched event listeners
- Add visual feedback parts

### 6. Testing

1. Press Play in Studio
2. Walk to equipment zones
3. Press **G** to toggle stats UI
4. Interact with equipment:
   - **Treadmill**: Step on the treadmill
   - **Boxing Ring**: Punch the targets
   - **Weight Machine**: Stand in the zone

### 7. Customization

Modify in `config.lua`:
- `Workouts` - Equipment stats (speed, damage, reps)
- `PlayerStats` - Max stamina, health
- `Sounds` - Volume levels
- `UI` - Update rates, fade times

### 8. Adding More Features

- **Animations**: Add animation IDs in equipment scripts
- **Sounds**: Replace sound IDs with your own
- **UI**: Customize colors/layout in `gym_ui.lua`
- **Leaderboard**: Use PlayerManager leaderboard system
- **Badges**: Create achievement system in PlayerManager

### Troubleshooting

**Scripts not working?**
- Check ServerScriptService for errors (F9 Output)
- Verify all ModuleScripts are in correct locations
- Ensure Workspace models match script names exactly

**Equipment not triggering?**
- Verify TouchZone/InteractZone has CanTouch = true
- Check that parts aren't anchored improperly
- Ensure humanoid detection is working

**UI not showing?**
- Check StarterPlayer scripts are LocalScripts
- Verify PlayerGui is accessible
- Try pressing G to toggle visibility

---

**Next Steps:**
- Add more equipment (rowing machine, pull-up bar, etc.)
- Create achievement/badge system
- Build NPC trainers
- Add rewards/shop system
- Create multiplayer challenges
