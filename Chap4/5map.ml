(* add 1 to each element of list *)
let rec add1 = function
    | [] -> []
    | hd::tl -> (hd + 1)::(add1 tl)

(* concatenate "3110" to each element of list *)
let rec concat3110 = function
    | [] -> []
    | hd::tl -> (hd^"3110")::(concat3110 tl)


(** abstract a list operation out of the above *)
let rec map f = function 
    | [] -> []
    | hd::tl -> (f hd)::(map f tl)

(** redefine the functions above *)
let add1_alt = map (fun x -> x + 1) 

let concat3110_alt = map (fun x -> x^"3110") 

(** test *)
let test_list = [1; 2; 3]
let test_string = ["fang"; "loves"; "ocaml"]
let () =
    (assert ((add1 test_list) = (add1_alt test_list)));
    (assert ((concat3110 test_string) =(concat3110_alt test_string)))
