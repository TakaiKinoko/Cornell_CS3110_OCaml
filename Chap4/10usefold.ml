let length l = List.fold_left (fun accum x -> accum + 1) 0 l

let reverse l = List.fold_left (fun accum x -> x::accum) [] l

let map f l = reverse(List.fold_left (fun accum x -> (f x)::accum) [] l)
let map' f l =  List.fold_right (fun x init -> (f x)::init) l []

let filter p l = reverse(List.fold_left (fun accum x -> if p x then x::accum else accum) [] l)
let filter' p l = List.fold_right (fun x init -> if p x then x::init else init) l []

(** tests *)
let l = [1;2;3;4;5;6;7;8;9]
let () = 
    print_endline(string_of_int (length l));
    (assert ((List.rev l)= (reverse l) ));
    (assert ((map (fun x -> x + 1) l) = (map' (fun x -> x + 1) l)));
    (assert ((filter (fun x -> if x mod 2 = 0 then true else false) l) = (filter' (fun x -> if x mod 2 = 0 then true else false) l)))