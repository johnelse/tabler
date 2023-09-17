open Cmdliner

let tabler samples waves =
  Printf.eprintf "samples = %d\n" samples;
  Printf.eprintf "waves = %d\n" waves

let samples =
  let doc = "Number of samples per waveform" in
  Arg.(value & opt int 2048 & info ["samples"] ~docv:"SAMPLES" ~doc)

let waves =
  let doc = "Number of waveforms to generate" in
  Arg.(value & opt int 256 & info ["waves"] ~docv:"WAVES" ~doc)

let cmd =
  let doc = "Generate a wavetable" in
  let man = [
  ] in
  let info = Cmd.info "tabler" ~doc ~man in
  let term = Term.(const tabler $ samples $ waves) in
  Cmd.v info term

let () =
  exit (Cmd.eval cmd)
