val generator_of_string : Lua_api.Lua.state -> string -> Expressions.generator_fn option

val generate :
  samples:int ->
  waves:int ->
  start_generator:Expressions.generator_fn ->
  end_generator:Expressions.generator_fn ->
  output_file:string ->
  (unit, string) Result.result
