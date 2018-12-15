(** Suppose we wanted to compute the sum of squares of the numbers from 0 up to n *)
let sum_sq n =
    (assert (n >= 0));
    let rec aux i accum =
        if i = n then accum + i * i
        else  aux (i+1) (accum + i * i)
    in aux 0 0

(** Another, clearer way of producing the same result in OCaml uses higher-order functions and the pipeline operator: *)
let (--) i j =
  let rec from i j l =
    if i>j then l
    else from i (j-1) (j::l)
    in from i j []

let square x = x*x
let sum = List.fold_left (+) 0

let sum_sq n =
  0--n                (* [0;1;2;...;n]   *)
  |> List.map square  (* [0;1;4;...;n*n] *)
  |> sum              (*  0+1+4+...+n*n  *)

(** We could improve our code a little further by using List.rev_map instead of List.map. List.rev_map is a tail-recursive version of map that reverses the order of the list. *)
let sum_sq n =
  0--n                    (* [0;1;2;...;n]   *)
  |> List.rev_map square  (* [n*n;...;4;1;0] *)
  |> sum                  (*  n*n+...+4+1+0  *)