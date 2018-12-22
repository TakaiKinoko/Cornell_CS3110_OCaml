(** an infinite sequence of 1*)
let rec ones = 1::ones

(** a and b alternates infinitely between 0 and 1 *)
let rec a = 0::b and b = 1::a

(** As the lists are infinite, the toplevel cannot print them in their entirety. 
    Instead, it indicates a cycle: the list cycles back to its beginning. 
*)

(** Even though these lists represent an infinite sequence of values, their representation in memory is finite: 
    they are linked lists with back pointers that create those cycles.*)

