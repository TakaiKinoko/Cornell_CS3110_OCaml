(** The standard library Set module is quite similar to the Map module. 
    Use it to create a module that represents sets of case-insensitive strings.
    Strings that differ only in their case should be considered equal by the set. *)

module type OrderedType = sig
    type t 
    val compare : t -> t -> int
end 

module Case_ins_string : (OrderedType with type t = string) = struct
    type t = string
    let compare x y =  String.(compare (lowercase_ascii x) (lowercase_ascii y))
end 

module CisSet = Set.Make(Case_ins_string)

open CisSet

(** Thanks to having Case_ins_string sharing contraints, these strings can be passed directly in *)
let set1 = empty |> add "grr" |> add "argh"
let set2 = empty |> add "GRR" |> add "gRr" |> add "aRGh"

let () = 
    assert (equal set1 set2)