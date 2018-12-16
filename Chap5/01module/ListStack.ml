(** a module for stacks implemented as lists: *)

module ListStack = struct 
    let empty = []

    let is_empty s = (s = [])

    let push x s = x::s

    let peek = function 
        | [] -> failwith "Empty"
        | x::_ -> x

    let pop = function 
        | [] -> failwith "Empty"
        | _::xs -> xs
end