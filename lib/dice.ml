(* Dice rolling system for Call of Cthulhu 7th Edition *)

(* Difficulty levels for skill checks *)
type difficulty = Regular | Hard | Extreme

(* Possible outcomes of a dice roll *)
type dice_result =
   | Critical_Success
   | Extreme_Success
   | Hard_Success
   | Regular_Success
   | Failure
   | Fumble

let roll_d100 () : int =
   Random.int 100 + 1

(* let determine_success (skill_value : int) (difficulty) (roll : int): dice_result =
   Fumble *)


(* TODO(human): Implement the core dice rolling functions here

   You'll need:
   1. roll_d100 : unit -> int
      - Returns random number from 1-100

   2. determine_success : int -> difficulty -> int -> dice_result
      - Takes skill_value, difficulty, and roll
      - Returns appropriate dice_result based on CoC 7th edition rules

   Remember:
   - Critical success on 01
   - Extreme success when roll d skill/5
   - Hard success when roll d skill/2
   - Regular success when roll d skill
   - Fumble on 96-00 (unless skill e 95)
   - Otherwise failure
*)
