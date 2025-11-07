open Alcotest
open Eldritch_matchness_lib.Dice

let print_dice result =
  match result with
  | Critical_Success -> "Critical_Success"
  | Extreme_Success -> "Extreme_Success"
  | Hard_Success -> "Hard_Success"
  | Regular_Success -> "Regular_Success"
  | Failure -> "Failure"
  | Fumble -> "Fumble"
;;

let equal_dice_result (a : dice_result) (b : dice_result) : bool = a = b
let dice_result_testable = testable (Fmt.of_to_string print_dice) equal_dice_result

let test_critical_success () =
  let result = determine_success 50 Regular 1 in
  let is_critical = equal_dice_result Critical_Success result in
  check bool "roll of 1 is critical" true is_critical
;;

let test_roll_range () =
  let result = roll_d100 () in
  check bool "roll is between 1 and 100" true (result >= 1 && result <= 100)
;;

let dice_test_casses =
  [ (* (character_skill, difficulty, roll, expected result) *)

    (* Extreme Difficulty Tests *)
    50, Extreme, 1, Critical_Success
  ; 50, Extreme, 5, Regular_Success
  ; 50, Extreme, 15, Failure
  ; 50, Extreme, 25, Failure
  ; 50, Extreme, 97, Fumble
  ; (* Hard Difficulty Tests *)
    50, Hard, 1, Critical_Success
  ; 50, Hard, 5, Hard_Success
  ; 50, Hard, 20, Regular_Success
  ; 50, Hard, 30, Failure
  ; 50, Hard, 98, Fumble
  ; (* Regular Difficulty Tests *)
    50, Regular, 1, Critical_Success
  ; 50, Regular, 5, Extreme_Success
  ; 50, Regular, 20, Hard_Success
  ; 50, Regular, 30, Regular_Success
  ; 50, Regular, 50, Regular_Success
  ; 50, Regular, 60, Failure
  ; 50, Regular, 96, Fumble
  ]
;;

let test_dice_test_cases () =
  List.iter
    (fun (character_skill, diff, roll, expected) ->
       let result = determine_success character_skill diff roll in
       check
         dice_result_testable
         (Printf.sprintf
            "character_skill of %d with difficulty %s and roll %d is %s"
            character_skill
            (string_of_difficulty diff)
            roll
            (string_of_dice_result result))
         expected
         result)
    dice_test_casses
;;

let () =
  run
    "Dice Tests"
    [ "Dice Test Cases", [ test_case "dice test cases" `Quick test_dice_test_cases ]
    ; "Critical Success Test", [ test_case "roll 1" `Quick test_critical_success ]
    ; "Roll Range Test", [ test_case "roll between 1 and 100" `Quick test_roll_range ]
    ]
;;
