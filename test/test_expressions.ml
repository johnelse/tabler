open Lua_api
open OUnit2
open Tabler_libs

let test_good_start _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"x + x") true;
  assert_equal (Expressions.call_start ~state ~value:5.0) 10.0

let test_good_end _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"x * x") true;
  assert_equal (Expressions.call_start ~state ~value:5.0) 25.0

let test_invalid_start _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"e . 78 & 32 ko0") false

let test_invalid_end _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"f 98 23 ++ 6^^^") false

let test_non_float_start _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"\"hi\"") false

let test_non_float_end _ =
  let state = LuaL.newstate () in
  assert_equal (Expressions.load_start ~state ~expression:"true") false

let suite =
  "expressions" >::: [
    "good_start" >:: test_good_start;
    "good_end" >:: test_good_end;
    "invalid_start" >:: test_invalid_start;
    "invalid_end" >:: test_invalid_end;
    "non_float_start" >:: test_non_float_start;
    "non_float_end" >:: test_non_float_end;
  ]
