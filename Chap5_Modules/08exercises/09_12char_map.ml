module CharMap = Map.Make (Char)

(** 9. 
    val empty : 'a t
    val add : key -> 'a -> 'a t -> 'a t 
    val remove : key -> 'a t -> 'a t *)

(** 10. 
    Char type has val compare : t -> t -> int defined in its module  *)

(** 11. *)
open CharMap
let map = empty |> add 'A' "Alpha" |> add 'E' "Echo"
                |> add 'S' "Sierra" |> add 'V' "Victor"

let () = 
    print_endline(find 'E' map)

let new_map = remove 'A' map

let () = 
    print_endline(string_of_bool (mem 'A' new_map))

let rec print_assoc_list = function
    | [] -> print_newline () 
    | (k, v)::tl -> print_char(k); print_endline(": "^v); print_assoc_list tl

let () = print_assoc_list (bindings new_map)


(** 12. *)

let b1 = CharMap.(empty |> add 'x' 0 |> add 'y' 1 |> bindings)

let b2 = CharMap.(empty |> add 'y' 1 |> add 'x' 0 |> bindings)

let b3 = CharMap.(empty |> add 'x' 2 |> add 'y' 1 |> remove 'x' |> add 'x' 0 |> bindings)


let () = 
    assert (b1 = b2);
    assert (b2 = b3);
    assert (b2 = b3)
