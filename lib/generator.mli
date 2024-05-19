(** Attempt to create a generator function from the given string. The state of
    the Lua interpreter must also be passed in.

    Supports the special values "saw", "sine", "square" and "triangle". If the
    string is one of these values then a generator for the corresponding basic
    waveform will be returned.

    If the string is not one of these values, attempt to interpret the string as
    a Lua expression and convert it into a generator function.

    This function will return None if the string is not one of the known special
    values, is not a valid Lua expression, or is a valid Lua expression that
    does not evaluate to a number type. *)
val generator_of_string : Lua_api.Lua.state -> string -> Expressions.generator_fn option

(** Generate a wavetable at [output_file], using the given generators
    [start_generator] and [end_generator]. [samples] is the number of samples
    per waveform; [waves] is the number of waveforms. *)
val generate :
  samples:int ->
  waves:int ->
  start_generator:Expressions.generator_fn ->
  end_generator:Expressions.generator_fn ->
  output_file:string ->
  (unit, string) Result.result
