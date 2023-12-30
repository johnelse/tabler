type waveform =
  | Saw
  | Sine
  | Square
  | Triangle

type generator_fn = float -> float

type generator =
  | Waveform of waveform
  | Custom of generator_fn

val generator_of_string : string -> generator option

val string_of_generator : generator -> string

val fn_of_generator : generator -> generator_fn
