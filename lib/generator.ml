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

type generator =
  | Waveform of waveform
  | Custom of (float -> float)

let generator_of_string str =
  match waveform_of_string str with
  | Some waveform -> Some (Waveform waveform)
  | None -> begin
    (* TODO - create custom generator. *)
    None
  end

let string_of_generator = function
  | Waveform waveform -> string_of_waveform waveform
  | Custom _ -> "custom"
