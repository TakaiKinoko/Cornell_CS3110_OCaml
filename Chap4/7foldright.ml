(**Both map and filter are really just looking at a single element at a time.
 What if we wanted to somehow combine all the elements of a list? *)

(** write a function that sums a list *)
let rec sum = function 
    | [] -> 0
    | hd::tl -> hd + (sum tl)

(** write a function that concatenates a list *)
let rec concat = function 
    | [] -> ""
    | hd::tl -> hd ^ (concat tl)

(** rewrite the functions to factor out just the initial value 
(we won't factor out an operator just yet) *)
let rec sum' init = function 
    | [] -> init
    | hd::tl -> hd + (sum' init tl)

let rec concat' init = function
    | [] -> init
    | h::t -> h + concat' init t

(** Now the only real difference left between sum' and concat' is the operator.
  That can also become an argument to a unified function we call combine: *)

let rec combine op init = function 
    | [] -> init
    | hd::tl -> op hd (combine op init tl)

let sum_alt = combine (+) 0

let concat_alt = combine (^) ""

(** OCAML fold_right signature: 
    val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b   *)
let rec fold_right op lst init = combine op init lst


(*test*)
let l = [1;2;3;4;5;6;7;8;9;10]
let stringl = ["fang"; "loves"; "ocaml"]

let () = 
  (assert (55 = (fold_right (+) l 0)));
  print_endline(fold_right (^) stringl "")