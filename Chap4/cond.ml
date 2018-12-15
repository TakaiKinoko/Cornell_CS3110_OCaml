(**  write a function that conditionally chooses which of two functions to apply based on a predicate *)

let cond p f1 f2 = 
    if p then f1 else f2


let num_list = [1;4;7;8;9;1008;20009]

(** transform the list into a list of 0 or 1 bit with 1 for even, 0 for odd*)

let new_list = 
    let transformer x = 
        cond (x mod 2 = 0) (fun x -> 1) (fun x -> 0) x
    in 
    List.map transformer num_list

let () = 
    List.iter print_int new_list; 
    print_newline(); 