type waveform =
  | Saw
  | Sine
  | Square
  | Triangle

type generator =
  | Waveform of waveform
  | Custom of (float -> float)

val generator_of_string : string -> generator option

val string_of_generator : generator -> string
