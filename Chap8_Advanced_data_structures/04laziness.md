### thunk vs laziness
From the fib example, it's clear that it would be useful if the computation of a thunk happened only once: when it is forced, the resulting value could be remembered, and if the thunk is ever forced again, that value could immediately be returned instead of recomputing it. That's the idea behind the OCaml Lazy module:

https://caml.inria.fr/pub/docs/manual-ocaml/libref/Lazy.html

```
module Lazy: 
    sig
        type 'a t = 'a lazy_t
        val force: 'a t -> 'a
    end
```
* a value of type **'a Lazy.t** is a value of type 'a whose computation has been delayed.

* the language is being lazy about evaluating it: it won't be computed until specifically demanded 

* to demand evaluation: **Lazy.force** which takes a **'a Lazy.t** and causes a **'a** inside it finally be produced. 

* The first time a lazy value is forced, the computation might take a long time. But the result is cached aka **memoized**, and any subsequent time that lazy value is forced, the memoized result will be returned immediately.


### use Lazy module
The Lazy module doesn't contain a function that produces a 'a Lazy.t. Instead, there is a keyword built-in to the OCaml syntax that does it: lazy e.

* syntax: 
```
lazy e
```
* static semantics: 
if e:u then lazy e: u Lazy.t

* dynamic semantics: 
lazy e does not evaluate e to a value. Instead it produced a delayed value aka lazy value that, when later forced, will evaluate e to a value v and return v. Moreover, that delayed value remembers that v is its forced value. And if the delayed value is ever forced again, it immediately returns v instead of recomputing it.

### lazy fib

```
let fib30long = take 30 fibs |> List.rev |> List.hd
```

