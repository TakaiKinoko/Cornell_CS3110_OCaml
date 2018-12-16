module type Set = sig 
    type 'a t

    (* [empty] is the empty set *)
    val empty : 'a t
    
    (* [mem x s] holds iff [x] is an element of [s] *)
    val mem : 'a -> 'a t -> bool

    (* [add x s] is the set [s] unioned with the set containing exactly [x] *)
    val add : 'a -> 'a t -> 'a t

    (* [elts s] is a list containing the elements of [s].  No guarantee
   * is made about the ordering of that list. *)
    val elts : 'a t -> 'a list

end 


(**an implementation of that interface using a list to represent the set.
 This implementation ensures that the list never contains any duplicate elements, since sets themselves do not: *)
module ListSetNoDups : Set = struct 
    type 'a t = 'a list

    let empty = []

    let mem x s = List.mem x s

    let add x s = if mem x s then s else x::s

    let elts s = s

end

(** a second implementation, which permits duplicates in the list*)
module ListSetDups : Set = struct
    type 'a t = 'a list

    let empty = []
    
    let mem = List.mem

    let add x s = x::s  (** O(1) *)

    let elts s = List.sort_uniq Pervasives.compare s  (** O(lgn) *)

end

(**val sort_uniq : ('a -> 'a -> int) -> 'a list -> 'a list *)