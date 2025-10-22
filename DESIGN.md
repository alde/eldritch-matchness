# Call of Cthulhu 7th Edition Text RPG - Design Document

## Project Overview

A single-player, text-based RPG implementing Call of Cthulhu 7th Edition mechanics in OCaml. The game will feature a complete investigation scenario with character creation, skill checks, sanity mechanics, and narrative choices.

## System Architecture

### Module Structure
```
eldritch-madness/
├── lib/
│   ├── dice.ml          # Dice rolling and probability
│   ├── character.ml     # Character stats and skills
│   ├── mechanics.ml     # CoC 7th edition rules
│   ├── narrative.ml     # Story and text display
│   ├── game_state.ml    # World state and save system
│   ├── parser.ml        # Command input processing
│   └── investigation.ml # Investigation-specific logic
├── scenarios/
│   └── mansion_mystery.ml # Sample investigation
├── bin/
│   └── main.ml          # Entry point
└── dune-project         # Build configuration
```

### Core Dependencies
- `dune` for build system
- `yojson` for save/load functionality
- `re` for text parsing (optional)
- Standard library only for core mechanics

## Data Type Design

### Character System
```ocaml
type characteristic = {
  value : int;
  half : int;
  fifth : int;
}

type characteristics = {
  strength : characteristic;
  constitution : characteristic;
  size : characteristic;
  dexterity : characteristic;
  appearance : characteristic;
  intelligence : characteristic;
  power : characteristic;
  education : characteristic;
}

type skill = {
  name : string;
  base_value : int;
  current_value : int;
  occupation_skill : bool;
}

type character = {
  name : string;
  occupation : string;
  characteristics : characteristics;
  skills : skill list;
  hit_points : int;
  magic_points : int;
  sanity_points : int;
  luck : int;
  inventory : string list;
}
```

### Dice Mechanics
```ocaml
type difficulty = Regular | Hard | Extreme

type dice_result =
  | Critical_Success
  | Extreme_Success
  | Hard_Success
  | Regular_Success
  | Failure
  | Fumble

type skill_check = {
  skill_name : string;
  skill_value : int;
  difficulty : difficulty;
  roll : int;
  result : dice_result;
  pushed : bool;
}
```

### Game State
```ocaml
type location = {
  id : string;
  name : string;
  description : string;
  exits : (string * string) list; (* direction * location_id *)
  clues : string list;
  npcs : string list;
  visited : bool;
}

type clue = {
  id : string;
  title : string;
  description : string;
  revealed : bool;
  required_skill : string option;
  sanity_loss : int;
}

type game_state = {
  character : character;
  current_location : string;
  locations : location list;
  clues : clue list;
  game_flags : (string * bool) list;
  investigation_progress : int;
  time_passed : int;
}
```

## Core Mechanics Implementation

### Dice Rolling System
Following CoC 7th Edition rules:
- d100 rolls against skill values
- Success levels: Regular (≤skill), Hard (≤skill/2), Extreme (≤skill/5)
- Critical success on 01, fumble on 96-00 (unless skill >95)
- Pushed rolls: second attempt with consequences on failure

```ocaml
let roll_d100 () = Random.int 100 + 1

let determine_success skill_value difficulty roll =
  let target = match difficulty with
    | Regular -> skill_value
    | Hard -> skill_value / 2
    | Extreme -> skill_value / 5
  in
  match roll with
  | 1 -> Critical_Success
  | r when r <= (skill_value / 5) -> Extreme_Success
  | r when r <= (skill_value / 2) -> Hard_Success
  | r when r <= skill_value -> Regular_Success
  | r when r >= 96 && skill_value < 95 -> Fumble
  | _ -> Failure
```

### Sanity System
- Starting sanity = POW characteristic
- Sanity loss from witnessing horrors or learning forbidden knowledge
- Temporary insanity on major sanity loss
- Indefinite insanity if sanity drops too low

### Investigation Flow
1. **Location Exploration**: Move between connected areas
2. **Clue Discovery**: Use skills to reveal information
3. **NPC Interaction**: Gather information through social skills
4. **Time Management**: Actions advance time, affecting story
5. **Crisis Resolution**: Final confrontation with supernatural threat

## Text Interface Design

### Command Parser
Support natural language commands:
- Movement: "go north", "enter library", "n"
- Examination: "look around", "examine desk", "search room"
- Skills: "use spot hidden", "make psychology roll"
- Inventory: "inventory", "use flashlight"
- Meta: "save game", "character sheet", "help"

### Narrative Display
- Rich text descriptions with atmospheric detail
- Clear skill check feedback with mechanical transparency
- Sanity loss warnings and consequences
- Progress tracking for investigation goals

## Sample Investigation: "The Blackwood Manor"

### Story Structure
**Setup**: Investigators called to examine mysterious disappearances at Victorian manor
**Investigation**: Explore manor rooms, interview staff, uncover dark history
**Climax**: Confront otherworldly entity in hidden basement ritual chamber
**Resolution**: Multiple endings based on investigation success and sanity

### Location Graph
```
Manor Grounds -> Front Hall -> Library
                           -> Drawing Room -> Kitchen
                           -> Staircase -> Upstairs Hall -> Bedrooms
                                        -> Attic
                           -> Basement -> Hidden Chamber
```

### Key Clues
1. **Torn Journal Pages** (Library, Spot Hidden): Reveal previous rituals
2. **Servant Testimony** (Kitchen, Psychology): Staff saw strange lights
3. **Ritual Circle** (Basement, Occult): Identify summoning pattern
4. **Family Portrait** (Drawing Room, History): Shows family curse timeline

### Mechanical Challenges
- **Skill Variety**: Different clues require different skills
- **Time Pressure**: Manor becomes more dangerous as night falls
- **Sanity Costs**: Learning truth costs mental stability
- **Multiple Solutions**: Various ways to resolve final threat

## Development Milestones

### Phase 1: Foundation (Week 1-2)
- Set up OCaml project with dune
- Implement dice rolling and basic character types
- Create simple character creation process
- Test skill check mechanics

### Phase 2: Core Systems (Week 3-4)
- Build location and navigation system
- Implement save/load functionality
- Create command parser for basic actions
- Add inventory and item management

### Phase 3: Investigation Engine (Week 5-6)
- Design clue revelation system
- Implement skill checks for clue discovery
- Add time progression mechanics
- Create NPC interaction framework

### Phase 4: Complete Scenario (Week 7-8)
- Build full Blackwood Manor investigation
- Add atmospheric text and descriptions
- Implement multiple ending system
- Polish user interface and error handling

## Learning Opportunities

### OCaml Concepts Covered
- **Algebraic Data Types**: Character stats, dice results, game states
- **Pattern Matching**: Command parsing, skill check evaluation
- **Modules**: Clean separation of game systems
- **Option Types**: Safe handling of missing data
- **Records**: Character sheets, locations, clues
- **Lists**: Inventories, skill collections, location connections
- **File I/O**: Save game persistence
- **Random Numbers**: Dice rolling system

### Design Patterns
- **State Machines**: Game progression and character states
- **Command Pattern**: Player action processing
- **Observer Pattern**: Game event notifications
- **Strategy Pattern**: Different skill check difficulties

This design provides a solid foundation for learning OCaml while building a genuinely engaging Call of Cthulhu experience. Each system builds naturally on OCaml's strengths, making the language concepts feel necessary rather than academic.
