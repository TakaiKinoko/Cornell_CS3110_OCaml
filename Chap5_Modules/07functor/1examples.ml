module type Dummy = sig
    val x : int
end

(** now a functor: *)
module IncX (Module: Dummy) = struct 
    let x = Module.x + 1
end

(** The functor's name is IncX. 
    It's a function from structures to structures. 
    Its input is named M, and the type of its input is X. 
    Its output is the structure that appears on the right-hand side of the equals sign: struct let x = M.x + 1.*)

(** Another way to think about IncX is that it's a parameterized structure. 
    The parameter that it takes is named M and has type X. 
    The structure itself has a single value named x in it. 
    The value that x has will depend on the parameter M. *)


(** since functors are functions, they can be applied: *)
module A = struct 
    let x = 0 
end 

module B = IncX(A)

module C = IncX(B)

(** tests *)
let () = 
    print_endline(string_of_int A.x);
    print_endline(string_of_int B.x);
    print_endline(string_of_int C.x);


(** Now another function that returns nothing similer *)
module MakeDiffDummy (Module: Dummy) = struct 
    let y = 42 (** this functor completely ignores its input structure *)
end 

module A' = MakeDiffDummy(A)

let () = 
    print_endline(string_of_int A'.y)