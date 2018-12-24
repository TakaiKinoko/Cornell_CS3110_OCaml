(** When the type of a key becomes more complicated than a built-in primitive type, we might want to write our own custom comparison function. 
    For example, suppose we want a map in which keys are records representing names, 
    and in which names are sorted alphabetically by last name then by first name.*)

type name = {first: string; last: string}

module Name = struct
    type t = name 
    let compare {first=first1; last=last1} {first=first2; last=last2} = 
        match Pervasives.compare last1 last2 with
        | 0 -> Pervasives.compare first1 first2 
        | c -> c
end

module NameMap = Map.Make(Name)

let k1 = {last="Kardashian"; first="Kourtney"}
let k2 = {last="Kardashian"; first="Kimberly"}
let k3 = {last="Kardashian"; first="Khloe"}
let k4 = {last="West"; first="Kanye"}

let nm = NameMap.(
    empty |> add k1 1979 |> add k2 1980 
          |> add k3 1984 |> add k4 1977)

let lst = NameMap.bindings nm

(** helper funcion to printout list *)
let rec print_name = function
    | [] -> ()
    | ({first=first;last=last}, yr)::tl -> 
        print_endline(first^" "^last^" was born in "^string_of_int yr);
        print_name tl

let () = print_name lst