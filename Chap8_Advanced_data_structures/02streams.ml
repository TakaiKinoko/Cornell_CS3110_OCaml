(* An ['a stream] is an infinite list of values of type ['a].
 * AF:  [Cons (x, f)] is the stream whose head is [x] and tail is [f()].
 * RI:  none.
 *)
type 'a stream =
  Cons of 'a * (unit -> 'a stream)

let rec from n = Cons (n, fun () -> from (n+1))

let nats = from 0