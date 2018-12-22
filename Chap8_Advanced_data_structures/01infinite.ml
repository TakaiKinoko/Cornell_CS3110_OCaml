(** an infinite sequence of 1*)
let rec ones = 1::ones

(** a and b alternates infinitely between 0 and 1 *)
let rec a = 0::b and b = 1::a