open Cmdliner
open Tabler_libs

let tabler samples waves start_waveform_str end_waveform_str =
  let start_waveform =
    match Generator.waveform_of_string start_waveform_str with
    | Some waveform -> waveform
    | None -> failwith ("Unrecognised waveform: " ^ start_waveform_str)
  in
  let end_waveform =
    match Generator.waveform_of_string end_waveform_str with
    | Some waveform -> waveform
    | None -> failwith ("Unrecognised waveform: " ^ end_waveform_str)
  in
  Printf.eprintf "samples = %d\n" samples;
  Printf.eprintf "waves = %d\n" waves;
  Printf.eprintf "start = %s\n" (Generator.string_of_waveform start_waveform);
  Printf.eprintf "end = %s\n" (Generator.string_of_waveform end_waveform)

let samples =
  let doc = "Number of samples per waveform" in
  Arg.(value & opt int 2048 & info ["samples"] ~docv:"SAMPLES" ~doc)

let waves =
  let doc = "Number of waveforms to generate" in
  Arg.(value & opt int 256 & info ["waves"] ~docv:"WAVES" ~doc)

let start_waveform =
  let doc = "Start waveform" in
  Arg.(value & opt string "sine" & info ["start"] ~docv:"START" ~doc)

let end_waveform =
  let doc = "End waveform" in
  Arg.(value & opt string "sine" & info ["end"] ~docv:"END" ~doc)

let cmd =
  let doc = "Generate a wavetable" in
  let man = [
  ] in
  let info = Cmd.info "tabler" ~doc ~man in
  let term = Term.(const tabler $ samples $ waves $ start_waveform $ end_waveform) in
  Cmd.v info term

let () =
  exit (Cmd.eval cmd)
