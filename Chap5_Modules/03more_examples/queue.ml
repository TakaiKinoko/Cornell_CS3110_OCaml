module type Queue = sig
    type 'a t
    val empty : 'a t
    val is_empty : 'a t -> bool
    val enqueue : 'a -> 'a t -> 'a t
    val peek : 'a t -> 'a option
    val dequeue : 'a t -> 'a t option
end

(**an implementation of a functional queue data structure as a list: *)
module ListQueue : Queue = struct
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

(* [{front=[a;b]; back=[e;d;c]}] represents the queue
     containing the elements a,b,c,d,e. That is, the
     back of the queue is stored in reverse order. 
     [{front; back}] is in *normal form* if [front]
     being empty implies [back] is also empty. 
     All queues passed into or out of the module 
     must be in normal form. *)
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

(** enqueue is O(1). With amortized analysis, dequeue is essentially O(1) too *)