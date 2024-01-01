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

class wavetable_generator ~samples ~waves ~start_generator ~end_generator : Mm.Audio.Generator.t =
  object(self)
    val total_samples = samples * waves
    val samples = samples
    val waves = waves
    val start_generator = start_generator
    val end_generator = end_generator

    val mutable volume = 1.
    val mutable position = 0
    val mutable dead = false

    method private omega_of_wave_position position =
      (float position) *. 2. *. Float.pi /. (float samples)

    method set_volume vol = volume <- vol
    method set_frequency _ = ()

    method fill buffer offset length =
      for buffer_position = 0 to length - 1 do
        let wave_position = position mod samples in
        let omega = self#omega_of_wave_position wave_position in
        let wavetable_position = (float (position / samples)) /. (float waves) in
        let value =
          ((start_generator omega) *. (1. -. wavetable_position)
          +. (end_generator omega) *. wavetable_position)
        in
        for channel = 0 to (Array.length buffer) - 1 do
          buffer.(channel).(offset + buffer_position) <- value
        done;
        position <- position + 1
      done

    method fill_add _ _ _ = ()

    method release = ()
    method dead = dead
  end

let generate ~samples ~waves ~start_generator ~end_generator ~output_file =
  let generator = new wavetable_generator ~samples ~waves ~start_generator ~end_generator in
  Wav.write ~channels:1 ~sample_rate:44100 ~samples:(samples * waves) ~generator ~output_file
