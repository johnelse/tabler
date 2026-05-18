open OUnit2

let suite =
  "base suite" >::: [
    Test_expressions.suite
  ]

let () =
  Printf.printf "%s" "Running library unit tests\n";
  run_test_tt_main suite
