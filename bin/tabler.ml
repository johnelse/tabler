open Cmdliner
open Lua_api
open Tabler_libs

let tabler samples waves start_generator_str end_generator_str _ =
  let state = LuaL.newstate () in
  LuaL.openlibs state;
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
  ignore (samples, waves, start_generator, end_generator)

let samples =
  let doc = "Number of samples per waveform" in
  Arg.(value & opt int 2048 & info ["samples"] ~docv:"SAMPLES" ~doc)

let waves =
  let doc = "Number of waveforms to generate" in
  Arg.(value & opt int 256 & info ["waves"] ~docv:"WAVES" ~doc)

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
  let term = Term.(const tabler $ samples $ waves $ start_generator $ end_generator $ output_file) in
  Cmd.v info term

let () =
  exit (Cmd.eval cmd)
