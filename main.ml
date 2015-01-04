(** 
    Command line driver for encoding a file or stdin into Ascii85.

    @author Christian Lindig
*)

let step x          = x * 22695477 + 1 
let s               = ref 0     (* never used with this value *)
let int () =
    ( s := step !s
    ; ((!s lsr 16) land 16383)
    )

(** [test] emits 1024 peseudo-random ints to stdout that can be used for
    testing *)

let test () =
    let rec loop = function
        | 1024  -> ()
        | n     -> 
            ( int () |> output_binary_int stdout
            ; loop (n+1)
            )
    in loop 0


(** Some code for testing and a [main] function that handles command line
    arguments *)

let main () =
    let argv        = Array.to_list Sys.argv in
    let this        = List.hd argv |> Filename.basename in
    let args        = List.tl argv in    
        match args with
        | ["-test"] -> test ()
        | [path]    -> Ascii85.encode_file  path 
        | []        -> Ascii85.encode stdin stdout
        | _	        -> Printf.eprintf "usage: %s [file]\n" this; exit 1 

let () = if not !Sys.interactive then begin main (); exit 0 end
