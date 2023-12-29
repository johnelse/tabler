(** Load a starting waveform function using the supplied Lua expression. *)
val load_start : state:Lua_api.Lua.state -> expression:string -> bool

(** Load a ending waveform function using the supplied Lua expression. *)
val load_end : state:Lua_api.Lua.state -> expression:string -> bool

(** Call the starting waveform function with the supplied value. *)
val call_start : state:Lua_api.Lua.state -> value:float -> float

(** Call the ending waveform function with the supplied value. *)
val call_end : state:Lua_api.Lua.state -> value:float -> float
