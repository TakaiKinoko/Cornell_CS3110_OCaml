(** If a module already provides a type t that can be compared, we can immediately use that module as an argument to Map.Make *)

module StringMap = Map.Make(String)

open StringMap 

let dict = add "s" "strawberry" (add "f" "fran" (add "e" "egg" (add "c" "cranberry" (add "b" "banana" (add "a" "apple" empty)))))

(** define a helper function that prints all members of an assoc list that's returned by Map.bindings *)
let rec print_string_dict = function 
    | [] -> print_newline ()
    | (k, v)::tl -> print_string(k ^ ":" ^ v ^ "  "); print_string_dict tl

let () = 
    print_string_dict(bindings dict);
    print_endline("Is it empty? " ^ string_of_bool (is_empty dict));
    print_endline("Is egg in the dict? " ^ string_of_bool (mem "egg" dict));
    print_endline("Is e in the dict? " ^ string_of_bool (mem "e" dict));
    let one_word = singleton "d" "dragonfruit" in
    let new_dict = union (fun ky v1 v2 -> Some v1) dict one_word in  (*union f m1 m2 computes a map whose keys is the union of keys of m1 and of m2. When the same binding is defined in both arguments, the function f is used to combine them. *)
    print_string_dict(bindings new_dict);
    print_endline("new map cardinality: " ^string_of_int (cardinal new_dict));
    print_endline("old map cardinality: " ^string_of_int (cardinal dict))