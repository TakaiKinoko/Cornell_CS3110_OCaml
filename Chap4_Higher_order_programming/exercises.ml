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
    print_endline(string_of_int (budget_rec expenses budget))


(** 11. library uncurried *)
let uncurried_nth (lst, n) = List.nth lst n

let uncurried_append (l1, l2) = List.append l1 l2

let uncurried_compare (a, b) = Char.compare a b

let uncurried_max (a, b) = Pervasives.max

(** 12. uncurry Write a function uncurry that takes in a curried function and returns the uncurried version of that function.*)

let uncurry f = (fun (x, y) -> f x y)
(**val uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c *)

(** 13. curry *)
(** val curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c *)
let curry f = (fun x y -> f (x,y))

(** testing *)
let l1 = [1;2;3]
let l2 = [4;5;6]

let () = 
    assert (curry (uncurry List.append) l1 l2 = List.append l1 l2)


(** 14. terse product *)
let terse_product_foldleft = List.fold_left ( *. ) 1.0

let terse_product_foldright = ListLabels.fold_right ~f: ( *. ) ~init: 1.0

let () = 
    assert (terse_product_foldleft floats = 3000.);
    assert (terse_product_foldleft floats = terse_product_foldright floats)


(** 15. map composition.  Show how to replace any expression of 
    the form List.map f (List.map g lst) 
    with an equivalent expression that calls List.map only once.*)
let map_composed (f: 'a -> 'b) (g: 'a -> 'b) (lst: 'a list) : 'b list =  List.map (fun elem -> f (g elem)) lst 

(** test *)
let l = [1;2;3;4;5]

let f = (fun x -> x + 1)
let g = (fun x -> x * 10)

let () =
    assert (List.map f (List.map g l) = (map_composed f g) l)


(** 16. more list fun *)
let longer_length = List.filter (fun x -> if String.length x > 3 then true else false) 

let add_1 = List.map (fun x -> x +. 1.) 

let combine_str strs sep = List.fold_left (fun accum x -> if accum = "" then x else accum ^ sep ^ x) "" strs

(** tests*)
let tl = ["I"; "can't"; "believe"; "OS"; "finals"; "was"; "that"; "hard"]
let () = 
    print_endline(combine_str tl "!");
    print_endline(combine_str (longer_length tl) " ")


(** 17. tree map *)
type 'a tree = 
    | Leaf 
    | Node of 'a * 'a tree * 'a tree

(** Write a function tree_map : ('a -> 'b) -> 'a tree -> 'b tree that applies a function to every node of a tree, 
    just like List.map applies a function to every element of a list.*)
let rec tree_map f t = 
    match t with 
    | Leaf -> Leaf
    | Node (x, left, right) -> Node (f x, tree_map f left, tree_map f right)

let add1 = tree_map (fun x -> x + 1)

(** tests *)
(** print out the tree in order*)
let rec print_tree tree = 
    match tree with 
    | Leaf -> print_string ""
    | Node(x, left, right) -> 
        print_tree left; 
        print_endline(string_of_int x);
        print_tree right

let test_tree = Node( 4, Node (2, Node(1, Leaf, Leaf), Node(3, Leaf, Leaf)), Node(5, Leaf, Leaf))
(**     4   
      2   5
    1  3     *)

let () = print_tree test_tree; print_tree (add1 test_tree)


(** 18. association list keys *)
let keys1 lst = List.fold_right (fun (k, _) init -> if List.mem k init then init else k::init) lst []
let keys2 lst = List.sort_uniq String.compare (List.map fst lst)
let keys3 lst = List.fold_left (fun accum (k, _) -> if List.mem k accum then accum else k::accum) [] lst (** tail recursive, so sublinear stack space*)

(** merge sort *)
let rec split (l : 'a list) : 'a list * 'a list =
  match l with
    [] -> ([] , [])
  | [x] -> ([x] , [])
  | x :: y :: xs -> 
      let (pile1, pile2) = split xs in 
      (x :: pile1, y :: pile2)

let rec merge_no_dup (comp : 'a -> 'a -> int ) (l1 : 'a list) (l2 : 'a list) : 'a list =
  match (l1, l2) with
    ([] , l2) -> l2
  | (l1 , []) -> l1
  | (x :: xs, y :: ys) ->
     if comp x y < 0 then 
        x :: merge_no_dup comp xs l2
     else if comp x y > 0 then 
        y :: merge_no_dup comp l1 ys
     else merge_no_dup comp xs l2

let keys4 lst = 
    let listpair = split (List.map fst lst) in 
    let l1 = fst listpair in
    let l2 = snd listpair in
    merge_no_dup String.compare l1 l2 

(** tests *)
let assoc_l = [("OCaml", 1); ("Scala", 2); ("Scheme", 3); ("OCaml", 4)]
let print_str_list = List.iter print_endline

let () = 
    print_endline("testing implementation 1: ");
    print_str_list (keys1 assoc_l);
    print_endline("testing implementation 2: ");
    print_str_list (keys2 assoc_l);
    print_endline("testing implementation 3: ");
    print_str_list (keys3 assoc_l);
    print_endline("testing implementation 4: ");
    print_str_list (keys4 assoc_l);