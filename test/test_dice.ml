open Alcotest
  open Eldritch_matchness_lib.Dice

  (* let test_critical_success () =
    let result = determine_success 50 Regular 1 in
    check (equal_dice_result) "roll of 1 is critical" Critical_Success result *)

    let test_roll_range () =
      let result = roll_d100 () in
      check bool "roll is between 1 and 100" true (result >= 1 && result <= 100)


let () =
  let open Alcotest in
  run "Dice Tests"
    [
      (* ("Critical Success Test", [ test_case "roll 1" `Quick test_critical_success ]); *)
      ("Roll Range Test", [ test_case "roll between 1 and 100" `Quick test_roll_range ]);
    ]
