(** 1. big list queue *)
module type Queue = sig
    type 'a t
    val empty : 'a t
    val is_empty : 'a t -> bool
    val enqueue : 'a -> 'a t -> 'a t
    val peek : 'a t -> 'a option
    val dequeue : 'a t -> 'a t option
end

(** sharing constraint *)
module ListQueue : (Queue with type 'a t = 'a list) = struct
    type 'a t = 'a list
    let empty = []
    let is_empty q = q = [] 
    let enqueue i q = q @ [i]  (** O(n) *)
    let peek = function
        | [] -> None
        | hd::_ -> Some hd
    let dequeue = function     (** O(1) *)
        | [] -> None
        | _::tl -> Some tl 

end

let fill_listqueue n =
    let rec loop n q =
        if n=0 then q
        else loop (n-1) (ListQueue.enqueue n q) in
    loop n ListQueue.empty

(** delays for more than 10 secs when n is as large as 100000 *)


(** 2. big two-list queue *)
module TwoListQueue : Queue = struct 
    type 'a t = {front : 'a list; back : 'a list}

    let empty = {front = []; back = []}

    let is_empty = function 
        | {front = []; back = []} -> true
        | _ -> false

    (* Helper function to ensure that a queue is in normal form. *)
    let norm = function 
        | {front = []; back} -> {front = List.rev back; back = []}
        | q -> q 

    let enqueue i q = norm {q with back = i::q.back}
    
    let peek = function 
        | {front = []; _} -> None
        | {front = x::_ ; _} -> Some x
    
    let dequeue = function 
        | {front = []; _} -> None
        | {front = _::xs ; back} -> Some (norm {front = xs; back})
end

let fill_twolistqueue n =
    let rec loop n q =
        if n=0 then q
        else loop (n-1) (TwoListQueue.enqueue n q) in
    loop n TwoListQueue.empty

(** delays for more than 10 secs when n is as large as 100000000 *)

(** 3.queue efficiency *)
