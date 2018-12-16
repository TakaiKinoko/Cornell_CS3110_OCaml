(** write two functions that filter out the even/odd nums in a list respectively *)
let rec odd = function 
    | [] -> []
    | hd::tl -> if hd mod 2 <> 0 then hd::(odd tl) else odd tl

let rec even = function
    | [] -> []
    | hd::tl -> if hd mod 2 = 0 then hd::(even tl) else even tl


(** abstract from the above functions a higher-order filter*)
let rec filter f = function 
    | [] -> []
    | hd::tl -> if f hd then hd::(filter f tl) else filter f tl

(** test *)
let l = [1;2;3;4;5;6;7;8;9;10]

let () = 
    (assert ((odd l) = (filter (fun x -> x mod 2 <> 0) l)));
    (assert ((even l) = (filter (fun x -> x mod 2 = 0) l)));