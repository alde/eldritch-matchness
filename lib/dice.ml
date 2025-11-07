[@@@warning "-26-27"]

(* Dice rolling system for Call of Cthulhu 7th Edition *)

(* Difficulty levels for skill checks *)
type difficulty =
  | Regular
  | Hard
  | Extreme

let string_of_difficulty (difficulty : difficulty) : string =
  match difficulty with
  | Regular -> "Regular"
  | Hard -> "Hard"
  | Extreme -> "Extreme"
;;

(* Possible outcomes of a dice roll *)
type dice_result =
  | Critical_Success
  | Extreme_Success
  | Hard_Success
  | Regular_Success
  | Failure
  | Fumble

let string_of_dice_result (result : dice_result) : string =
  match result with
  | Critical_Success -> "Critical_Success"
  | Extreme_Success -> "Extreme_Success"
  | Hard_Success -> "Hard_Success"
  | Regular_Success -> "Regular_Success"
  | Failure -> "Failure"
  | Fumble -> "Fumble"
;;

let roll_d100 () : int = Random.int 100 + 1

let determine_success (skill_value : int) difficulty (roll : int) : dice_result =
  let result =
    match roll with
    | 1 -> Critical_Success
    | r when r <= skill_value / 5 -> Extreme_Success
    | r when r <= skill_value / 2 -> Hard_Success
    | r when r <= skill_value -> Regular_Success
    | r when r >= 96 && skill_value < 95 -> Fumble
    | _ -> Failure
  in
  match difficulty with
  | Extreme when result = Extreme_Success -> Regular_Success
  | Extreme when result = Hard_Success -> Failure
  | Extreme when result = Regular_Success -> Failure
  | Hard when result = Extreme_Success -> Hard_Success
  | Hard when result = Hard_Success -> Regular_Success
  | Hard when result = Regular_Success -> Failure
  | Regular when result = Regular_Success -> Regular_Success
  | _ -> result
;;
