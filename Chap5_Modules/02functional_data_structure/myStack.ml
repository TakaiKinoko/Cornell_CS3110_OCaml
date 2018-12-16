(**Because 'a stack is abstract in the Stack module type, no client of this data structure will be able to discern whether stacks are being implemented with the built-in list type or the custom one we just used.  *)

module type Stack_verbose = sig
    type 'a stack
    val empty    : 'a stack
    val is_empty : 'a stack -> bool
    val push     : 'a -> 'a stack -> 'a stack
    val peek     : 'a stack -> 'a
    val pop      : 'a stack -> 'a stack
end

(** rewrite the above module type in a less verbose way *)
module type Stack = sig
    type 'a t
    val empty    : 'a t
    val is_empty : 'a t -> bool
    val push     : 'a -> 'a t -> 'a t
    val peek     : 'a t -> 'a
    val pop      : 'a t -> 'a t
end

(** another implementation of stack using algebraic data types *)
module MyStack : Stack = struct
    type 'a t = 
    | Empty 
    | Entry of 'a * 'a t

    let empty = Empty

    let is_empty s = s = Empty

    let push x s = Entry(x, s)

    let peek = function 
    | Empty -> failwith "Empty"
    | Entry(x, _) -> x

    let pop = function 
    | Empty -> failwith "Empty"
    | Entry(x, xs) -> xs

end 