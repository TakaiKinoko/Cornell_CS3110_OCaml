(** different ways to write a function that takes two arguments *)

(** curried: *)
let add x y = x + y

(** uncurried: *)
let add' t = (fst t) + (snd t)

let add'' (x,y) = x + y
