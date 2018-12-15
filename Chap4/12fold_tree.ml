type 'a tree = 
    | Leaf
    | Node of 'a * 'a tree * 'a tree

(** develop a fold functional for 'a tree similar to our fold_right over 'a list  *)

(** Here's a way we could rewrite fold_right that will help us think a little more clearly: *)
type 'a list = 
    | Nil
    | Cons of 'a * 'a list

let rec foldlist init op = function 
    | Nil -> init
    | Cons (hd, tl) -> op hd (foldlist init op tl)


let rec foldtree init op = function 
    | Leaf -> init
    | Node (a, l, r) -> op a (foldtree init op l) (foldtree init op r)


(** implement tree functions using foldtree *)
let size t = foldtree 0 (fun _ l r -> 1 + l + r) t