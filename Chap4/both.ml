(**write a function that applies two functions to the same argument and returns a pair of the result: *)

let both f g x = (f x, g x)

let () = 
    match both (fun x -> x * x) (fun x -> x * 2) 3 with 
    | x, y -> print_endline(string_of_int x); print_endline(string_of_int y);