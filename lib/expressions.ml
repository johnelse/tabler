open Lua_api

let test ~state ~fn_name =
  Lua.getglobal state fn_name;
  Lua.pushnumber state 1.0;
  Lua.call state 1 1;
  Lua.isnumber state (-1)

let load_internal ~state ~fn_name ~expression =
  let fn_str = Printf.sprintf "function %s(x) return %s end" fn_name expression in
  if LuaL.dostring state fn_str
  then test ~state ~fn_name
  else false

let call ~state ~fn_name ~value =
  Lua.getglobal state fn_name;
  Lua.pushnumber state value;
  let _ = Lua.call state 1 1 in
  Lua.tonumber state (-1)

type generator_fn = float -> float

let next_fn_number = ref 0
let next_fn_name () =
  let name = Printf.sprintf "fn_%d" !next_fn_number in
  incr next_fn_number;
  name

let load ~state ~expression =
  let fn_name = next_fn_name () in
  if load_internal ~state ~fn_name ~expression
  then Some (fun value -> call ~state ~fn_name ~value)
  else None
