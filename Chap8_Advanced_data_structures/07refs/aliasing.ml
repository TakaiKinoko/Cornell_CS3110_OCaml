let x = ref 42
let y = ref 42
let z = x  (** z is x's alias *)

let () = x := !x + 1

let w = (!y) + (!z)

(*test*)
let () = 
    print_endline(string_of_int w);
    print_endline("x's content is: "^string_of_int !x);
    print_endline("y's content is: "^string_of_int !y);
    print_endline("z's content is: "^string_of_int !z);