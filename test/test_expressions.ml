open Lua_api
open OUnit2
open Tabler_libs

let test_good_expression_1 _ =
  let state = LuaL.newstate () in
 match Expressions.load ~state ~expression:"x + x" with
  | Some fn -> assert_equal (fn 5.0) 10.0
  | None -> assert_failure "Valid expression was rejected"

let test_good_expression_2 _ =
  let state = LuaL.newstate () in
 match Expressions.load ~state ~expression:"x * x" with
  | Some fn -> assert_equal (fn 5.0) 25.0
  | None -> assert_failure "Valid expression was rejected"

let test_multiple_expressions _ =
  let state = LuaL.newstate () in
 match Expressions.load ~state ~expression:"x + x" with
  | Some fn1 -> begin
    assert_equal (fn1 5.0) 10.0;
   match Expressions.load ~state ~expression:"x * x" with
   | Some fn2 -> begin
     assert_equal (fn1 5.0) 10.0;
     assert_equal (fn2 5.0) 25.0;
   end
   | None -> assert_failure "Valid expression was rejected"
  end
  | None -> assert_failure "Valid expression was rejected"

let test_invalid_expression _ =
  let state = LuaL.newstate () in
  match Expressions.load ~state ~expression:"e . 78 & 32 ko0" with
  | Some _ -> assert_failure "Invalid expression was accepted"
  | None -> ()

let test_non_float_expression _ =
  let state = LuaL.newstate () in
  match Expressions.load ~state ~expression:"\"hi\"" with
  | Some _ -> assert_failure "Expression that doesn't return a float was accepted"
  | None -> ()

let suite =
  "expressions" >::: [
    "good_expression_1" >:: test_good_expression_1;
    "good_expression_2" >:: test_good_expression_2;
    "multiple_expressions" >:: test_multiple_expressions;
    "invalid_expression" >:: test_invalid_expression;
    "non_float_expression" >:: test_non_float_expression;
  ]
