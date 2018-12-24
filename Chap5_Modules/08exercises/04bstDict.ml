(** 4. binary search tree dictionary 
Write a module BstDict that implements the Dictionary module type using the tree type.*)

module type Dictionary = sig 
    type ('k, 'v) t
    val empty : ('k, 'v) t
    val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
    val lookup : 'k -> ('k, 'v) t -> 'v
end



(** SOL2: writing a functor that turns a Tree module into a Dictionary, where Tree is an OrderedType that wrapes around tree type *)
module type OrderedType = sig
    type t
    val compare: t -> t -> int
end

type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree 

module Tree : OrderedType = struct 
    type t = Node
    let compare x y = 
        match x, y with   
        | 
end

module Make_BstDict(T: Tree) -> Dictionary = 

