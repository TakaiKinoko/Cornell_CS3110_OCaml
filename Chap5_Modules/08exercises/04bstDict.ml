(** 4. binary search tree dictionary 
Write a module BstDict that implements the Dictionary module type using the tree type.*)

module type Dictionary = sig 
    type ('k, 'v) t
    val empty : ('k, 'v) t
    val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
    val lookup : 'k -> ('k, 'v) t -> 'v
end

type ('k, 'v) tree = Leaf | Node of ('k * 'v) * ('k, 'v) tree * ('k, 'v) tree

(** a BstDict that takes keys of primitive types *)
module BstDict : Dictionary = struct
    type ('k, 'v) t = Leaf | Node of ('k * 'v) * ('k, 'v) t * ('k, 'v) t    (** tricky!! *)
    
    let empty = Leaf
    
    let rec insert k v t = match t with 
        | Leaf -> Node((k,v), Leaf, Leaf)
        | Node((k1,v1), l, r) -> 
            if k = k1 then Node((k1,v), l, r)
            else if Pervasives.compare k k1 <0 then Node((k1,v1), insert k v l, r)
            else Node((k1,v1), l, insert k v r)
    
    let rec lookup k t = match t with 
        | Leaf -> failwith "Not found"
         | Node((k1,v1), l, r) -> 
            if k = k1 then v1
            else if Pervasives.compare k k1 <0 then lookup k l
            else lookup k r
end

(** tests *)
open BstDict
let d = empty |> insert 3 "apple" |> insert 1 "grapes" |> insert 2 "kiwi" |> insert 4 "pineapple"
let () = 
    print_endline(lookup 1 d);
    print_endline(lookup 2 d);
    print_endline(lookup 3 d);
    print_endline(lookup 4 d)

(** SOL2: writing a functor that turns a Tree module into a Dictionary, where Tree is an OrderedType that wrapes around tree type 
module type OrderedTree = sig
    type ('k, 'v) t 
    type ('k, 'v) tree = Leaf | Node of ('k * 'v) * ('k, 'v) tree * ('k, 'v) tree  (** note when to use asteriks, and when "," *)
    val compare : 'k -> 'v -> ('k, 'v) tree -> int 
end

module BstTree = struct 
    type ('k, 'v) t 
    type ('k, 'v) tree = Leaf | Node of ('k * 'v) * ('k, 'v) tree * ('k, 'v) tree  (** note when to use asteriks, and when "," *)
    let compare k v tree =   
        match tree with 
        | Leaf -> failwith "Empty tree"
        | Node ((k1, v1), l, r) -> Pervasives.compare k k1
end 

module Make_BstDict(T: OrderedTree) : Dictionary = struct
    type ('k, 'v) t = ('k,) T.tree
    type 
end
*)