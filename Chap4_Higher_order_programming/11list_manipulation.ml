(** three different ways for writing functions that manipulate lists: 
   directly as a recursive function that pattern matches against the empty list and against cons, 
   using fold functions, 
   and using other library functions. *)

(** Consider writing a function lst_and: bool list -> bool, such that lst_and [a1; ...; an] returns whether all elements of the list are true. 
    That is, it evaluates the same as a1 && a2 && ... && an. 
    When applied to an empty list, it evaluates to true. *)

let rec list_and_rec = function 
    | [] -> true
    | hd::tl -> hd && (list_and_rec tl)

let list_and_fold l = List.fold_left (fun accum x -> accum && x) true l

let list_and_lib = List.for_all (fun x -> x)  

(** Performance analysis 
 The worst-case running time of all three functions is linear in the length of the list. But the first function, 
 lst_and_rec has the advantage that it need not process the entire list: it will immediately return false the first time they discover a false element in the list. 
 The second function, lst_and_fold, will always process every element of the list. As for the third function lst_and_lib, according to its documentation it

returns (p a1) && (p a2) && ... && (p an).

So like lst_and_rec it need not process every element.*)

let bool_list = [true; true; false; false]
let () = 
    print_endline(string_of_bool (list_and_rec bool_list));
    print_endline(string_of_bool (list_and_fold bool_list));
    print_endline(string_of_bool (list_and_lib bool_list));