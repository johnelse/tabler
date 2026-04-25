(** The type of generator functions. [position] is a normalised wave index,
    i.e. the first wave in the table will be generated with position=0.0, and
    the last wave in the table will be generated with position=1.0. *)
type generator_fn = position:float -> theta:float -> float

(** Load an function using the supplied expression, and return a float -> float
    function which invokes this function. *)
val load : state:Lua_api.Lua.state -> expression:string -> generator_fn option
