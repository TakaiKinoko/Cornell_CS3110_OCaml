type 'a tree = 
    | Leaf
    | Node of 'a * 'a tree * 'a tree

(** [mem x t] is [true] iff [x] is a member of [t]. *)
let rec mem x t = 
    match t with 
    | Leaf -> false
    | Node (i, l, r) -> 
        if x = i then true  
        else if x < i then mem x l
        else mem x r

(** [insert x t] is [t] . *)  
let rec insert x t = 
    match t with
    | Leaf -> Node(x, Leaf, Leaf)
    | Node(i, l, r) ->
        if x = i then t
        else if x < i then Node(i, insert x l, r)
        else Node(i, l, insert x r)

        