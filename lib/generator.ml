type waveform =
  | Saw
  | Sine
  | Square
  | Triangle

let waveform_of_string str =
  match String.lowercase_ascii str with
  | "saw" -> Some Saw
  | "sine" -> Some Sine
  | "square" -> Some Square
  | "triangle" -> Some Triangle
  | _ -> None

let string_of_waveform = function
  | Saw -> "saw"
  | Sine -> "sine"
  | Square -> "square"
  | Triangle -> "triangle"
