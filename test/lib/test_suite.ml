open OUnit2

let suite =
  "base suite" >::: [
    Test_expressions.suite
  ]

let () = run_test_tt_main suite
