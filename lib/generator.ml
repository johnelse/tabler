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

let generator_of_string state str =
  match str with
  | "saw" -> Some saw
  | "sine" -> Some sin
  | "square" -> Some square
  | "triangle" -> Some triangle
  | expression -> Expressions.load ~state ~expression
