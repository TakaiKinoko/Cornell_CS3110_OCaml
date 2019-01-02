(** note that counter is in global scope *)
let counter = ref 0

let next_val = 
    fun () -> counter := !counter + 1;  (** increment and assign *)
    !counter 

(* test *)
let () = 
    print_endline(string_of_int !counter);
    print_endline(string_of_int (next_val()));
    print_endline(string_of_int (next_val()));

(* deterministic v.s. nondeterministic function
* deterministic: for a given input, they always produced the same output. 
* nondeterministic: e.g. functions in the Random module, Pervasives.read_line, and the next_val defined here
*)



