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
  | Custom of Expressions.generator_fn

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

let pi_by_2 = Float.pi /. 2.0
let three_pi_by_2 = 3. *. pi_by_2

let saw x =
  if x < Float.pi
  then x /. Float.pi
  else x /. Float.pi -. 2.

let square x =
  if x < Float.pi
  then 1.
  else -1.

let triangle x =
  if x < pi_by_2
  then x /. pi_by_2
  else begin
    if x < three_pi_by_2
    then 2.0 -. x /. pi_by_2
    else x /. pi_by_2 -. 3.0
  end

let fn_of_generator = function
  | Waveform Saw -> (fun x -> saw x)
  | Waveform Sine -> (fun x -> sin x)
  | Waveform Square -> (fun x -> square x)
  | Waveform Triangle -> (fun x -> triangle x)
  | Custom fn -> fn
