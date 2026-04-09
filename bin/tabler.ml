open Cmdliner
open Lua_api
open Tabler_libs

let tabler samples waves single_cycle_generator_str start_generator_str end_generator_str output_file =
  let state = LuaL.newstate () in
  LuaL.openlibs state;
  match single_cycle_generator_str with
  | Some str -> begin
    match Generator.generator_of_string state str with
    | Some generator -> begin
      Generator.generate ~samples ~waves:1
        ~start_generator:generator
        ~end_generator:generator
        ~output_file
    end
    | None -> failwith ("Unrecognised generator: " ^ str)
  end
  | None -> begin
    let start_generator =
      match Generator.generator_of_string state start_generator_str with
      | Some generator -> generator
      | None -> failwith ("Unrecognised generator: " ^ start_generator_str)
    in
    let end_generator =
      match Generator.generator_of_string state end_generator_str with
      | Some generator -> generator
      | None -> failwith ("Unrecognised generator: " ^ end_generator_str)
    in
    Generator.generate ~samples ~waves
      ~start_generator
      ~end_generator
      ~output_file
  end

let samples =
  let doc = "Number of samples per waveform" in
  Arg.(value & opt int 2048 & info ["samples"] ~docv:"SAMPLES" ~doc)

let waves =
  let doc = "Number of waveforms to generate" in
  Arg.(value & opt int 256 & info ["waves"] ~docv:"WAVES" ~doc)

let single_cycle_generator =
  let doc = "Single cycle generator" in
  Arg.(value & opt (some string) None & info ["single-cycle"] ~docv:"SINGLE-CYCLE" ~doc)

let start_generator =
  let doc = "Start generator" in
  Arg.(value & opt string "sine" & info ["start"] ~docv:"START" ~doc)

let end_generator =
  let doc = "End generator" in
  Arg.(value & opt string "sine" & info ["end"] ~docv:"END" ~doc)

let output_file =
  let doc = "The file to write." in
  Arg.(required & pos 0 (some string) None & info [] ~docv:"OUTPUTFILE" ~doc)

let cmd =
  let doc = "Generate a wavetable" in
  let man = [
  ] in
  let info = Cmd.info "tabler" ~doc ~man in
  let term =
    Term.(const tabler
          $ samples $ waves $ single_cycle_generator
          $ start_generator $ end_generator $ output_file)
  in
  Cmd.v info term

let () =
  exit (Cmd.eval_result cmd)
