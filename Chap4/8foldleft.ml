(** sum: walk across a list of integers and sum them, we could store the current sum in the accumulator *)
let rec sum accum =  function 
    | [] -> accum 
    | hd::tl -> sum (hd + accum) tl

let rec concat accum = function 
    | [] -> accum 
    | hd::tl -> concat (accum^hd) tl

(** summarize *)
let rec fold_left accum f = function 
    | [] -> accum
    | hd::tl -> fold_left (f accum hd) f tl

let sum' = fold_left 0 (+)
let concat' = fold_left "" (^)

(** ocaml signature: 
 val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)