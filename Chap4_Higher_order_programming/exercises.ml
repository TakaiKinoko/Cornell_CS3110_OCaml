(** 1. partial application *)

(** 2. *)
let square x = x * x
let ($) f x = f x    (** defines an infix operator $ that used in f $ x, applies f to x *)

let () = 
    assert ((square $ 2 + 2) = 16);
    assert ((square 2 + 2) = 6)

(** 3. *)
let (@@) f g x =  x |> g |> f    (** f @@ g x will essentially be f(g(x)) *)

let () = 
    assert ((String.length @@ string_of_int) 1 = 1);
    assert ((String.length @@ string_of_int) 10 = 2);
    assert ((String.length @@ string_of_int) 100 = 3)

(** 4. Generalize twice to a function repeat,
     such that repeat f n x applies f to x a total of n times *)
let repeat f n x = 
    let rec aux i acc = 
        if i = n then acc
        else aux (i + 1) (f acc)
    in aux 0 x

let f = (fun x -> x + 1)

let () = 
    assert ((repeat f 0 1) = 1);
    assert ((repeat f 1 1) = 2);
    assert ((repeat f 10 1) = 11)

(** 5. *)
(** Use fold_left to write a function product_left that computes the product of a list of floats. 
    The product of the empty list is 1.0. 
    Hint: recall how we implemented sum in just one line of code in lecture. *)
let product_left lst = List.fold_left (fun accum x -> x *. accum) 1. lst

(** Use fold_right to write a function product_right that computes the product of a list of floats. *)
let product_right lst = List.fold_right (fun x y -> x *. y) lst 1. 

let floats = [3.0; 2.0; 10.0; 50.0]

let () = 
    assert (product_left floats = 3000.);
    assert (product_left floats = product_right floats)


(** 6. clip *)
let clip n = 
    if n < 0 then 0
    else if n > 10 then 10
    else n

let cliplist_map lst = List.map clip lst

let rec cliplist_rec lst = 
    match lst with 
    | [] -> []
    | hd::tl -> (clip hd)::(cliplist_rec tl) 

let int_lst = [-9; 0; 30; 10; 2; -3]

let () = 
    assert (cliplist_map int_lst = [0; 0; 10; 10; 2; 0]);
    assert (cliplist_map int_lst = cliplist_rec int_lst)


(** 7. sum_cube_odd *)
let (--) i j =
    let rec aux i j l = 
        if i > j then l
        else aux i (j-1) (j::l)
    in aux i j []

let sum_cube_odd n = 
    List.fold_left (fun accum x-> x * x * x + accum) 0 (List.filter (fun x -> if x mod 2 = 1 then true else false) (0 -- n)) 

let () = 
    assert (sum_cube_odd 5 = 1 + 3 * 3 * 3 + 5 * 5 * 5)


(** 8. sum_cube_odd pipeline *)
let sum_cube_odd_pipelined n = 
    (0 -- n) |> List.filter (fun x -> if x mod 2 = 1 then true else false) |> List.fold_left (fun accum x-> x * x * x + accum) 0

let () = 
    assert ( sum_cube_odd 10 =  sum_cube_odd_pipelined 10)


(** 9. exists *)
let rec exists_rec p l = 
    match l with 
    | [] -> false
    | hd::tl -> (p hd) || (exists_rec p tl)

let exists_fold p l = List.fold_left (fun accum x -> accum || (p x)) false l

let exists_lib p l = List.exists p l

let test_list = [1;3;5;7;9;10]
let test_list2 = [1;3;5;7;9;11]
let is_even = (fun x -> if x mod 2 = 0 then true else false)

let () = 
    assert (exists_rec is_even test_list = exists_fold is_even test_list);
    assert (exists_fold is_even test_list = exists_lib is_even test_list);
    assert (exists_rec is_even test_list2 = exists_fold is_even test_list2);
    assert (exists_fold is_even test_list2 = exists_lib is_even test_list2)


(** 10. budget *)
let budget_foldl exps bud = 
    List.fold_left (fun rest x -> rest - x) bud exps 

let budget_foldr exps bud = 
    bud - List.fold_right (fun x sum -> x + sum) exps 0 

let rec budget_rec exps bud = 
    match exps with 
    | [] -> bud
    | hd::tl -> budget_rec tl (bud - hd)


let expenses = [10; 100; 500; 1]
let budget = 1000

let () = 
    print_endline(string_of_int (budget_foldl expenses budget));
    print_endline(string_of_int (budget_foldr expenses budget));
    print_endline(string_of_int (budget_rec expenses budget));


(** 11. library uncurried *)
