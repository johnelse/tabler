(** The type of generator functions. *)
type generator_fn = float -> float

(** Load an function using the supplied expression, and return a float -> float
    function which invokes this function. *)
val load : state:Lua_api.Lua.state -> expression:string -> generator_fn option
