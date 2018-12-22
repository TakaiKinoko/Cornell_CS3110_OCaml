(* An ['a stream] is an infinite list of values of type ['a].
 * AF:  [Cons (x, f)] is the stream whose head is [x] and tail is [f()].
 * RI:  none.
 *)
type 'a stream =
  Cons of 'a * (unit -> 'a stream)

let rec from n = Cons (n, fun () -> from (n+1))

let nats = from 0

(** in comparison, if without using thunk, stack overflow is gonna happen in the natural number definition 
    let rec from n = Cons (n, from (n+1));;
    let nats = from 0;;
    Stack overflow during evaluation (looping recursion?). *)

(** define operations on streams *)
(* [hd s] is the head of [s] *)
let hd =  function
    | Cons (hd, _) -> hd

let hd_better (Cons (h, _)) = h

(* [tl s] is the tail of [s] *)
let tl (Cons (_, tf)) = tf ()

(* [take n s] is the list of the first [n] elements of [s] *)
let rec take n (Cons (hd, tf)) =
    if n > 0 then  hd::(take (n - 1) (tf ())) 
    else []

let rec take_better n s = 
    if n = 0 then []
    else hd s::take (n-1) (tl s)

(* [drop n s] is all but the first [n] elements of [s] *)
let rec drop n s = 
    if n = 0 then s 
    else drop (n-1) (tl s)

let () = 
    List.iter (fun x -> print_int x; print_string " ") (take 100 nats);
    print_newline ()

(* [square <a;b;c;...>] is [<a*a;b*b;c*c;...]. *)
let rec square (Cons (h, tf)) =
  Cons (h*h, fun () -> square (tf ()))

(* [sum <a1;b1;c1;...> <a2;b2;c2;...>] is
 * [<a1+b1;a2+b2;a3+b3;...>] *)
let rec sum (Cons (h1, tf1)) (Cons (h2, tf2)) = 
    Cons(h1 + h2, fun () -> sum (tf1 ()) (tf2()))

(* [map f <a;b;c;...>] is [<f a; f b; f c; ...>] *)
let rec map f (Cons (hd, tf)) =
    Cons (f hd, fun () -> map f (tf ()))

(* [map2 f <a1;b1;c1;...> <a2;b2;c2;...>] is
 * [<f a1 b1; f a2 b2; f a3 b3; ...>] *)
let rec map2 f (Cons (h1, tf1)) (Cons (h2, tf2)) = 
    Cons(f h1 h2, fun () -> map2 f (tf1 ()) (tf2 ()))

(** redifine square and sum *)
let squre' = map (fun n -> n*n)
let sum' = map2 (+)

(** redefine nats *)
let rec nats = Cons(0, fun () -> map (fun x -> x + 1) nats)

let () = 
    List.iter (fun x -> print_int x; print_string " ") (take 10 nats);
    print_newline ()