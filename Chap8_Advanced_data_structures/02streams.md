### template for defining functions on streams

* Pattern match against the input stream(s), which must be Cons of a head and a tail function (a thunk).

* Construct a stream as the output, which must be Cons of a new head and a new tail function (a thunk).

* In constructing the new tail function, delay the evaluation of the tail by immediately starting with fun () -> ....

* Inside the body of that thunk, recursively apply the function being defined (square or sum) to the result of forcing a thunk (or thunks) to evaluate.