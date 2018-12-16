(**We don't have to specify the sharing constraint in the original definition of the module. We can create a structure, bind it to a module name, 
  then bind it to another module name with its types being either abstract or exposed: *)
module type Arith = sig
  type t
  val zero  : t
  val one   : t
  val (+)   : t -> t -> t
  val ( * ) : t -> t -> t
  val (~-)  : t -> t
end

module Ints = struct
  type t    = int
  let zero  = 0
  let one   = 1
  let (+)   = Pervasives.(+)
  let ( * ) = Pervasives.( * )
  let (~-)  = Pervasives.(~-)
end

module IntsAbstracted : Arith = Ints
(* IntsAbstracted.(1 + 1) is illegal *)

module IntsExposed : (Arith with type t = int) = Ints
(* IntsExposed.(1 + 1) is legal *)

(*This can be a useful technique for testing purposes: provide one name for a module that clients use in which the types are abstract, and provide another name that implementers use for testing in which the types are exposed.*)


(** tests *)
let () = 
    print_endline (string_of_int IntsExposed.(1 + 1));
    print_endline (string_of_int IntsExposed.(~-100)); 