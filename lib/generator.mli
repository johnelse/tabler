type waveform =
  | Saw
  | Sine
  | Square
  | Triangle

val waveform_of_string : string -> waveform option

val string_of_waveform : waveform -> string
