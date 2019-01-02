## Specification of Modules
#### purpose:
not for clients (they can only read interface), but to explain the implementation to other implementers or maintainers of the module. 

#### what's inappropriate: 
* copy the specifications of functions found in the module interface into the module implementation.
* why? Copying runs the risk of introducing inconsistency as the program evolves, because programmers don't keep the copies in sync. Copying code and specifications is a major source (if not the major source) of program bugs. In any case, implementers can always look at the interface for the specification.

#### implementation comments categorization
1. a module implementation may define new types and functions that are purely **internal** to the module. If their significance is not obvious, these types and functions should be documented in much the same style that we have suggested for documenting interfaces.
1. **data abstraction** 
```
(** A set is an unordered collection in which multiplicity is ignored. *)
module type Set = sig

  (** the type representing a set whose elements are type ['a] *)
  type 'a set

  (** the set containing no elements *)
  val empty : 'a set

  (** [mem x s] is whether [x] is a member of set [s] *)
  val mem : 'a -> 'a set -> bool

  (** [add x s] is the set containing all the elements of [s]
      as well as [x]. *)
  val add : 'a -> 'a set -> 'a set

  (** [rem x s] is the set containing all the elements of [s],
      minus [x]. *)
  val rem : 'a -> 'a set -> 'a set

  (** [size s] is the cardinality of [s] *)
  val size: 'a set -> int

  (** [union s1 s2] is the set containing all the elements that
      are in either [s1] or [s2]. *)
  val union: 'a set -> 'a set -> 'a set

  (** [inter s1 s2] is the set containing all the elements that
      are in both [s1] and [s2]. *)
  val inter: 'a set -> 'a set -> 'a set
end
```
```
(* Implementation of sets as lists with duplicates *)
module ListSetDups : Set = struct
  type 'a set = 'a list
  let empty = []
  let mem = List.mem
  let add x l = x :: l
  let rem x = List.filter ((<>) x)
  let rec size = function
    | [] -> 0
    | h :: t -> size t + (if mem h t then 0 else 1)
  let union l1 l2 = l1 @ l2
  let inter l1 l2 = List.filter (fun h -> mem h l2) l1
end
```
* Notice that the types of the functions do not need to be written down in the above implementation. They aren't needed because they're already present in the signature, just like the specifications that are also in the signature don't need to be replicated in the structure.
```
(* Implementation of sets as lists without duplicates *)
module ListSetNoDups : Set = struct
  type 'a set = 'a list
  let empty = []
  let mem = List.mem
  (* add checks if already a member *)
  let add x l = if mem x l then l else x :: l 
  let rem x = List.filter ((<>) x)
  let size = List.length (* size is just length if no duplicates *)
  let union l1 l2 = (* check if already in other set *)
    List.fold_left (fun a x -> if mem x l2 then a else x :: a) l2 l1
  let inter l1 l2 = List.filter (fun h -> mem h l2) l1
end
```
* An important reason why we introduced the writing of function specifications was to enable local reasoning: once a function has a spec, we can judge whether the function does what it is supposed to without looking at the rest of the program. We can also judge whether the rest of the program works without looking at the code of the function. However, we cannot reason locally about the individual functions in the three module implementations just given. The problem is that we don't have enough information about the relationship between the concrete type (int list) and the corresponding abstract type (set). This lack of information can be addressed by adding two new kinds of comments to the implementation: the abstraction function and the representation invariant for the abstract data type. We turn to discussion of those, next.