type waveform =
  | Saw
  | Sine
  | Square
  | Triangle

type generator =
  | Waveform of waveform
  | Custom of Expressions.generator_fn

val generator_of_string : Lua_api.Lua.state -> string -> generator option

val string_of_generator : generator -> string

val fn_of_generator : generator -> Expressions.generator_fn
