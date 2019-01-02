(** You've gotta like the name :P 
With ref, we can build recursive functions without using rec *)

let rec fact n = 
    if n = 0 then 1 else n * fact(n-1)

let fact0 = ref (fun x -> x)

let fact n = (* note: no [rec] *)
    if n = 0 then 1 else n * (!fact0) (n-1)

let () = fact0 := fact   
 
let x = fact 5 (* ==> 120 *)

(* test *)
let () = 
    print_endline(string_of_int (fact 5));
    print_endline(string_of_int (fact 6))

(** compress the above seperated functions into one? *)
let fact_terse n = 
    let fact0 = ref (fun x -> x) in
    if n = 0 then 1 else n * (!fact0) (n-1)
let () = fact0 := fact  
(* doesn't work!!! *)

let () = 
    print_endline(string_of_int (fact_terse 5));
    print_endline(string_of_int (fact_terse 6))