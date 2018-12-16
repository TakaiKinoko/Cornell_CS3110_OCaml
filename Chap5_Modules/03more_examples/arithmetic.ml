(**a module type that represents values that support the usual operations from arithmetic, or more precisely, a field: *)
module type Arith = sig
    type t
    val zero : t
    val one : t
    val (+) : t -> t -> t
    val ( * ) : t -> t -> t
    val (~-) : t -> t  (** ~ indicates a unary negation operator *)
    val to_string : t -> string
end

module Ints : Arith = struct
    type t = int
    
    let zero = 0
    let one = 1

    let (+) = Pervasives.(+)
    let ( * ) = Pervasives.( * )
    let (~-) = Pervasives.(~-)

    let to_string = string_of_int
end

(** Outside of the module Ints, the expression Ints.(one + one) is perfectly fine,
     but Ints.(1 + 1) is not, because t is abstract *)

(** testing *)
let make_num (num:int): Ints.t = 
    (assert (num >= 0));
    let rec aux i acc = 
        if i > num then acc 
        else if i = 1 then aux (i + 1) Ints.one
        else aux (i + 1) Ints.(acc + one)
    in aux 0 Ints.zero

let () = 
    print_endline (Ints.(to_string (one + one)));
    print_endline (Ints.to_string (make_num 3));
    print_endline (Ints.to_string (make_num 10));