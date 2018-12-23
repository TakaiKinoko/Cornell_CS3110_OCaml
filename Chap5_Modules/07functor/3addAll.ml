(** Here is a functor that takes in a structure named S that matches the Set signature, 
    then produces a new structure having a single function named add_all in it:*)

module type Set = sig
  type 'a t

  (* [empty] is the empty set *)
  val empty : 'a t

  (* [mem x s] holds iff [x] is an element of [s] *)
  val mem   : 'a -> 'a t -> bool

  (* [add x s] is the set [s] unioned with the set containing exactly [x] *)
  val add   : 'a -> 'a t -> 'a t

  (* [elts s] is a list containing the elements of [s].  No guarantee
   * is made about the ordering of that list. *)
  val elts  : 'a t -> 'a list
end

module AddAll (S: Set) = struct 
    let add_all lst set = 
        let add' s x = S.add x s in 
        List.fold_left add' set lst
end 