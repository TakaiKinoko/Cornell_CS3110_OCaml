(* write a function that composes two other functions: *)

let compose f h x = f (h x) 

let double x = x * 2
let square x = x * x 

let square_then_double = compose double square (** partial function *)

let () = 
    print_endline(string_of_int(square_then_double 1));
    print_endline(string_of_int(square_then_double 2));