### template for defining functions on streams

* Pattern match against the input stream(s), which must be Cons of a head and a tail function (a thunk).

* Construct a stream as the output, which must be Cons of a new head and a new tail function (a thunk).

* In constructing the new tail function, delay the evaluation of the tail by immediately starting with fun () -> ....

* Inside the body of that thunk, recursively apply the function being defined (square or sum) to the result of forcing a thunk (or thunks) to evaluate.


### redifine nats (natural number) with streams
```
let rec nats = Cons(0, fun () -> map (fun x -> x + 1) nats)
```

Why does this work? 
Intuitively, nats is <0; 1; 2; 3; ...>, so mapping the increment function over nats is <1; 2; 3; 4; ...>. If we cons 0 onto the beginning of <1; 2; 3; 4; ...>, we get <0; 1; 2; 3; ...>, as desired. 
**The recursive value definition is permitted, because we never attempt to use nats until after its definition is finished.** In particular, the thunk delays nats from being evaluated on the right-hand side of the definition.

