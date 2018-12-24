(** 7. write a module that implements the fraction module type below *)
module type Fraction = sig
    (* A fraction is a rational number p/q, where q != 0.*)
    type t

    (* [make n d] is n/d. Requires d != 0. *)
    val make : int -> int -> t

    val numerator   : t -> int
    val denominator : t -> int
    val toString    : t -> string
    val toReal      : t -> float

    val add : t -> t -> t
    val mul : t -> t -> t
end

type fraction = {num:int; denom:int}

module Fraction : Fraction = struct 
    type t = fraction
 
    let make num denom = 
        if denom = 0 then failwith "denominator can't be zero"
        else {num = num; denom = denom}
 
    let numerator f = f.num

    let denominator f = f.denom

    let toString f = string_of_int f.num ^ "/" ^ string_of_int f.denom

    let toReal f = float_of_int f.num /. float_of_int f.denom

    let add f1 f2 = {num = f1.num*f2.denom + f1.denom*f2.num; denom = f1.denom * f2.denom}
    
    let mul f1 f2 = {num = f1.num * f2.num; denom = f1.denom*f2.denom}
end


(* tests *)
open Fraction
let f1 = make 1 3
let f2 = make 1 6
let () =
    print_endline(toString f1);
    print_endline(toString f2);
    print_endline(toString (add f1 f2));
    print_endline(toString (mul f1 f2))

(** 8.Fraction reduced 
    
    Modify your implementation of Fraction to ensure these invariants hold of every value v of type t that is returned from make, add, and mul:
        1. v is in reduced form
        2. the denominator of v is positive
 *)


(* [gcd x y] is the greatest common divisor of [x] and [y].
 * requires: [x] and [y] are positive.
 *)
let rec gcd (x: int) (y: int) : int = 
    (*assert (x >= 0 && y > 0);*)
    if x = 0 then y
    else if (x<y) then gcd (y-x) x
    else gcd y (x-y)

module Fraction_reduced : Fraction = struct 
    type t = fraction

    let make num denom = 
        if denom = 0 then failwith "denominator can't be zero"
        else if num = 0 then {num = 0; denom = abs (denom)}
        else
        let sign = (num > 0 && denom > 0) || (num < 0 && denom <0) in  
        let gcd = gcd (abs num) (abs denom) in 
        if sign then 
            {num = abs (num / gcd); denom = abs (denom / gcd)}
        else 
            {num = - abs (num / gcd) ; denom = abs (denom / gcd)}

    let numerator f = f.num

    let denominator f = f.denom

    let toString f = string_of_int f.num ^ "/" ^ string_of_int f.denom

    let toReal f = float_of_int f.num /. float_of_int f.denom

    let add f1 f2 = 
        let num = f1.num * f2.denom + f1.denom * f2.num in 
        let denom = f1.denom * f2.denom in 
        make num denom

    let mul f1 f2 = make (f1.num * f2.num) (f1.denom*f2.denom)
end

(** tests *)
open Fraction_reduced 
let f1 = make 1 3
let f2 = make 1 6
let f3 = make 1 (-3)
let f4 = make (-1) 6
let f5 = make (-2) (-6)

let () = 
    print_endline(toString f1);         (* should be 1/3*)
    print_endline(toString f2);         (* should be 1/6*)
    print_endline(toString f3);         (* should be -1/3*)
    print_endline(toString f4);         (* should be -1/6*)
    print_endline(toString f5)          (* should be 1/3*)

let () = 
    print_endline(toString (add f1 f2));(* should be 1/2*)
    print_endline(toString (mul f1 f2));(* should be 1/18*)
    print_endline(toString (add f1 f3));(* should be 0/9*)
    print_endline(toString (mul f2 f5)) (* should be 1/18*)