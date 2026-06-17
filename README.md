# MegaGYM - Roblox Fitness Experience

A luxury gym and fitness hotel experience in Roblox with interactive equipment, boxing ring, and various workout stations.

## Features

- **Interactive Boxing Ring** - Full-sized boxing ring with physics interactions
- **Fitness Equipment** - Treadmills, weight machines, benches, dumbbells
- **Hotel Vibe Atmosphere** - Modern lighting, polished floors, professional décor
- **Player Interactions** - Sit on benches, use equipment, interact with objects
- **Leaderboard System** - Track workouts and achievements
- **Ambient Music & Sounds** - Audio system for gym experience

## Project Structure

```
gym-Roblox/
├── src/
│   ├── server/
│   │   ├── equipment/
│   │   │   ├── treadmill.lua
│   │   │   ├── boxing_ring.lua
│   │   │   └── weight_machine.lua
│   │   ├── player/
│   │   │   └── player_manager.lua
│   │   └── main.lua
│   ├── client/
│   │   ├── ui/
│   │   │   └── gym_ui.lua
│   │   ├── input/
│   │   │   └── player_input.lua
│   │   └── main.lua
│   └── shared/
│       ├── config.lua
│       └── utils.lua
├── models/
│   └── gym_layout.rbxl
└── README.md
```

## Getting Started

1. Clone this repository
2. Open `gym_layout.rbxl` in Roblox Studio
3. Review the scripts in `src/` directories
4. Customize configuration in `src/shared/config.lua`
5. Test in Roblox Studio

## Installation in Roblox Studio

1. Create a new Roblox game place
2. Import the scripts from this repository into ServerScriptService and StarterPlayer
3. Add the models and workspace layout
4. Run and test!

## Features In Development

- [ ] Workout stat tracking
- [ ] Achievement system
- [ ] Personal training NPCs
- [ ] Multiplayer workout challenges
- [ ] Loot crates/rewards
- [ ] Custom outfit store
