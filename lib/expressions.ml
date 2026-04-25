open Lua_api

let test ~state ~fn_name =
  Lua.getglobal state fn_name;
  Lua.pushnumber state 0.0;
  Lua.pushnumber state 1.0;
  Lua.call state 2 1;
  Lua.isnumber state (-1)

let load_internal ~state ~fn_name ~expression =
  let fn_str = Printf.sprintf "function %s(position, theta) return %s end" fn_name expression in
  if LuaL.dostring state fn_str
  then test ~state ~fn_name
  else false

let call ~state ~fn_name ~position ~theta =
  Lua.getglobal state fn_name;
  Lua.pushnumber state position;
  Lua.pushnumber state theta;
  let _ = Lua.call state 2 1 in
  Lua.tonumber state (-1)

type generator_fn = position:float -> theta:float -> float

let next_fn_number = ref 0
let next_fn_name () =
  let name = Printf.sprintf "fn_%d" !next_fn_number in
  incr next_fn_number;
  name

let load ~state ~expression =
  let fn_name = next_fn_name () in
  if load_internal ~state ~fn_name ~expression
  then Some (fun ~position ~theta -> call ~state ~fn_name ~position ~theta)
  else None
