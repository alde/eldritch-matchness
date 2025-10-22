# Claude Code Guidelines for Call of Cthulhu RPG

This file provides guidance to Claude Code when working with this OCaml-based Call of Cthulhu RPG project.

## Learning-First Approach

This project is for practicing OCaml and problem-solving skills through making a Call of Cthulhu text-based RPG. Claude should prioritize learning over efficiency, but things should be correct and idiomatic OCaml.

### When User Gets Stuck

**DO NOT** provide direct code solutions unless explicitly requested and confirmed.

**DO** help by:
1. **Asking clarifying questions** about their current approach
2. **Suggesting problem-solving strategies** (break it down, work through examples, etc.)
3. **Pointing to relevant concepts** without showing implementation
4. **Helping debug reasoning** by walking through their logic
5. **Providing hints about edge cases** they might be missing
6. **Suggesting simpler test cases** to verify understanding

### Example Responses

❌ **Avoid**: "Here's the solution: `List.fold_left ...`"

✅ **Prefer**:
- "What happens when you trace through your algorithm with the example input?"
- "Have you considered what should happen when the list is empty?"
- "Try working through a simpler case first - what about just 2 elements?"
- "What data structure would help you track both position and state?"

### Confirming Solution Requests

If the user explicitly asks for code help, confirm with:
> "Just to confirm - would you like me to show you how to do it, or would you prefer hints to work through it yourself?"

Only provide direct solutions after explicit confirmation that they want the code.

### Framework and Setup

Normal coding assistance (build setup, debugging compilation errors, framework improvements) is always welcome.

## Commit Standards

### Conventional Commits
Use [conventional commit](https://www.conventionalcommits.org/) format:
```
type(scope): description

[optional body]

[optional footer]
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

**Examples**:
- `feat(dice): add advantage/disadvantage mechanics`
- `fix(character): handle sanity loss edge cases`
- `docs: update README with build instructions`
- `test(mechanics): add skill check test cases`

### Attribution
- **Never** add Claude as co-author
- **Optional**: Include attribution in commit message body like "Generated with Claude Code"

## OCaml Code Quality

### File Formatting
- **Use ocamlformat** - All files must be formatted with ocamlformat
- **No trailing whitespace** - All files must be clean
- **Final newlines** - Every file must end with exactly one newline character
- **Consistent indentation** - Follow ocamlformat conventions (2 spaces)

### OCaml-Specific Standards
- **Use Jane Street Base** - Prefer Base over stdlib when possible
- **Explicit opens** - Use `open Base` at top of files when needed
- **Type annotations** - Add type annotations for learning clarity
- **Pattern matching** - Prefer exhaustive pattern matching
- **Immutable data** - Default to immutable structures

### Git Staging
- **NEVER use** `git add .` or `git add -A` - these add unintended files
- **Use specific files**: `git add lib/character.ml` for individual files
- **Use tracked updates**: `git add -u` to stage only modified tracked files
- **Be intentional** - always review what you're staging with `git status`

## OCaml Conventions

### Naming
- **Modules**: PascalCase (`Character`, `Dice`, `GameMechanics`)
- **Functions**: snake_case (`roll_dice`, `check_skill`, `apply_sanity_loss`)
- **Types**: snake_case (`skill_check_result`, `character_stats`)
- **Variants**: PascalCase (`Success`, `Failure`, `CriticalSuccess`)
- **Records**: snake_case fields (`{ name; sanity; hit_points }`)

### Code Style
```ocaml
(* Good: Clear type definitions with learning-focused comments *)
type skill_check_result =
  | Success of int          (* Roll succeeded, value is degree of success *)
  | Failure of int          (* Roll failed, value is degree of failure *)
  | CriticalSuccess         (* Roll was 1-5% of skill value *)
  | CriticalFailure         (* Roll was 96-100 or fumble *)

(* Good: Explicit function signatures for learning *)
let check_skill ~skill_value ~roll : skill_check_result =
  match roll with
  | r when r <= skill_value / 5 -> CriticalSuccess
  | r when r <= skill_value -> Success (skill_value - r)
  | _ -> Failure (r - skill_value)
```

### Testing Standards
- **Use Alcotest** - Follow established test patterns
- **Test edge cases** - Empty lists, boundary values, invalid inputs
- **Descriptive test names** - `test_sanity_loss_below_zero_sets_insane`
- **All tests must pass** - Never commit with failing tests

### Comment Style
```ocaml
(* Learning-focused comments explain the "why" behind OCaml patterns *)
let apply_damage character damage =
  (* Using pattern matching here demonstrates OCaml's strength with ADTs *)
  match character.status with
  | Healthy -> { character with hit_points = character.hit_points - damage }
  | Unconscious -> character  (* Already down, no further damage *)
  | Dead -> character         (* Death is permanent (usually) *)
```

### Project Structure
```
lib/           # Core game logic modules
├── character.ml    # Character creation and management
├── dice.ml         # Dice rolling and probability
├── mechanics.ml    # Core game mechanics
└── dune           # Library build configuration

bin/           # Executable entry points
├── main.ml         # Main game loop
└── dune           # Executable build configuration

test/          # Test modules
├── test_dice.ml    # Dice rolling tests
├── test_character.ml  # Character system tests
└── dune           # Test build configuration
```

## Learning Guidelines

### Core Learning Goals
- **Functional programming** - Emphasize immutability and pure functions
- **Type system mastery** - Use ADTs, records, and modules effectively
- **Pattern matching** - Leverage OCaml's powerful pattern matching
- **Module system** - Understand interfaces and implementation hiding
- **Error handling** - Use `Result` and `Option` types appropriately

### Encourage Exploration
- Ask "What if we modeled this differently?"
- Suggest trying multiple approaches to the same problem
- Point out trade-offs between different OCaml features
- Encourage writing tests first to clarify thinking
