open Lua_api

let start_fn_name = "start_fn"
let end_fn_name = "end_fn"

let test ~state ~fn_name =
  Lua.getglobal state fn_name;
  Lua.pushnumber state 1.0;
  Lua.call state 1 1;
  Lua.isnumber state (-1)

let load ~state ~fn_name ~expression =
  let fn_str = Printf.sprintf "function %s(x) return %s end" fn_name expression in
  if LuaL.dostring state fn_str
  then test ~state ~fn_name
  else false

let call ~state ~fn_name ~value =
  Lua.getglobal state fn_name;
  Lua.pushnumber state value;
  let _ = Lua.call state 1 1 in
  Lua.tonumber state (-1)

let load_start ~state ~expression =
  load ~state ~fn_name:start_fn_name ~expression

let load_end ~state ~expression =
  load ~state ~fn_name:end_fn_name ~expression

let call_start ~state ~value =
  call ~state ~fn_name:start_fn_name ~value

let call_end ~state ~value =
  call ~state ~fn_name:end_fn_name ~value
