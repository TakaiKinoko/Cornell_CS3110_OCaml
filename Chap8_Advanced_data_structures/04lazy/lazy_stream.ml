(** get rid of the thunk, use a lazy value as the tail of the lazy stream *)
type 'a lazystream = 
    Cons of 'a * 'a lazystream Lazy.t

(** now implement fibonacci with both streams and lazy streams. 
Try computing the 30th fib with both, lazy streams will be much faster than the standard streams *)

module StreamFibs = struct 
    type 'a stream = 
        | Cons of 'a * (unit -> 'a stream)

    let hd : 'a stream -> 'a = 
        fun (Cons (h, _)) -> h

    let tl : 'a stream -> 'a stream = 
        fun (Cons (_, t)) -> t ()

    let rec take_aux n (Cons (h, t)) lst = 
        if n = 0 then lst
        else take_aux (n-1) (t ()) (h::lst)
    
    let take : int -> 'a stream -> 'a list = 
        fun n s -> List.rev (take_aux n s [])
    
    let nth : int -> 'a stream -> 'a =
        fun n s -> List.hd (take_aux (n+1) s [])

    let rec sum : int stream -> int stream -> int stream = 
        fun (Cons (h_a, t_a)) (Cons (h_b, t_b)) ->
            Cons (h_a + h_b, fun () -> sum (t_a ()) (t_b ()))

    let rec fibs = 
        Cons(1, fun () -> 
            Cons(1, fun () -> 
                sum (tl fibs) fibs))

    let nth_fib n =
        nth n fibs

end

module LazyFibs = struct 
    type 'a lazystream = 
        | Cons of 'a * 'a lazystream Lazy.t

    let hd : 'a lazystream -> 'a = 
        fun (Cons (h, _)) -> h

    let tl : 'a lazystream -> 'a lazystream = 
        fun (Cons (_, t)) -> Lazy.force t
    
    let rec take_aux n (Cons (h, t)) lst = 
        if n = 0 then lst 
        else take_aux (n-1) (Lazy.force t) (h::lst) 
    
    let take : int -> 'a lazystream -> 'a list = 
        fun n s -> List.rev (take_aux n s [])
    
    let nth : int -> 'a lazystream -> 'a = 
        fun n s -> List.hd (take_aux (n+1) s [])
    
    let rec sum : int lazystream -> int lazystream -> int lazystream =
        fun (Cons (h_a, t_a)) (Cons (h_b, t_b)) ->
            Cons (h_a + h_b, lazy (sum (Lazy.force t_a) (Lazy.force t_b)))

    let rec fibs = 
        Cons(1, lazy (
            Cons(1, lazy (
                sum (tl fibs) fibs))))
    
    let nth_fib n =
        nth n fibs
end
