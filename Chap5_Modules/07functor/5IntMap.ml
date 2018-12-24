(** the double semicolon inside the struct can be omitted. (it's also better to NOT use ;; in source code!!) *)
module IntMap = Map.Make(struct type t = int;; let compare = Pervasives.compare end)

open IntMap

(**sig: val add: key -> 'a -> 'a t -> 'a t *)
let m1 = add 1 "one" empty
let m2 = add 1 1. empty

(** tests *)
(**sig: val find: key -> 'a t -> 'a  *)
let () = 
    print_endline(find 1 m1);
    print_endline(string_of_bool (mem 42 m1));
    print_endline(string_of_float (find 1 m2))

(** NOTE that an IntMap is a map that has Int as its keys, values on the other hand can be other types 
    Although in general the map could have any value type, once we add a single value to a map, that "pins down" the value type of THAT PARTICULAR map*)
