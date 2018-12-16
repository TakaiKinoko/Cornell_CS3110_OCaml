module type Stack = sig
    type 'a t
    val empty    : 'a t
    val is_empty : 'a t -> bool
    val push     : 'a -> 'a t -> 'a t
    val peek     : 'a t -> 'a
    val pop      : 'a t -> 'a t
    val format : (Format.formatter -> 'a -> unit) -> Format.formatter -> 'a t -> unit
end


module ListStack : Stack = struct
    type 'a t = 'a list
    let empty = []

    let is_empty s = (s = [])

    let push x s = x::s

    let peek = function 
        | [] -> failwith "Empty"
        | x::_ -> x

    let pop = function 
        | [] -> failwith "Empty"
        | _::xs -> xs
        
    let format fmt_elt fmt s =
        Format.fprintf fmt "[";
        List.iter (fun elt -> Format.fprintf fmt "%a; " fmt_elt elt) s; 
        Format.fprintf fmt "]"
end