(**Since functors are really just parameterized modules, 
    we can use them to produce functions that are parameterized on any structure that matches a signature. 
    That can help to eliminate code duplication.  *)

module type StackSig = sig
    type 'a t
    val empty : 'a t
    val push : 'a -> 'a t -> 'a t
    val peek : 'a t -> 'a
end 

module ListStack = struct 
    type 'a t = 'a list
    let empty = []
    let push x s = x::s
    let peek = function 
        | [] -> failwith "Empty"
        | hd::_ -> hd 
end

module MyStack = struct 
    type 'a t = Empty | Entry of 'a * 'a t
    let empty = Empty
    let push x s = Entry (x, s)
    let peek = function Empty -> failwith "empty" | Entry(x,_) -> x
end

(** suppose we wanted to test ListStack *)
let () = 
    (assert (ListStack.(empty |> push 1 |> peek) = 1))

(** Unfortunately, to test a MyStack, we'd have to duplicate that code:*)
let () = 
    (assert (MyStack.(empty |> push 1 |> peek) = 1))

(** Functors offer a better solution. 
    We can write a functor that is parameterized on the stack implementation, 
    and produces the test for that implementation: *)

module StackTester (S: StackSig) = struct 
    assert(S.(empty |> push 1 |> peek) = 1)
end 

module MyStackTester = StackTester(MyStack)
module ListStackTest = StackTester(ListStack)

