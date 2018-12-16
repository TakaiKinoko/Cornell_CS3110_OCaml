### use modules in utop
e.g. to use "dict.ml", type the following in utop
```
# #use "dict.ml";;
# open AssocListDict;;
# let d = insert 1 "one" empty;;
```

### abstract v.s. concrete type from a module
* If the module AssocListDict isn't associated with the type Dictionary, its type is concrete therefore can be known to the client. 

* But once indicated that the module has type Dictionary, the type AssocListDict.t has become abstract. Clients of the module are no longer permitted to know that it is implemented with a list.

### benefit of having abstract type
With encapsulation provided, if we later wanted to change the representation, we could safely do so. The client would never know!

### to_string
When designing an interface with an abstract type, you will almost certainly want at least one function that returns something other than that type. For example, it's often useful to provide a to_string function.

e.g. in arithmetic.ml

### sharing constraints
Sometimes you actually want to expose the type in an implementation of a module. You might like to say "the module Ints implements Arith and the type t is int," and allow external users of the Ints module to use the fact that Ints.t is int.

OCaml lets you write sharing constraints that refine a signature by specifying equations that must hold on the abstract types in that signature. If T is a module type containing an abstract type t, then T with type t = int is a new module type that is the same as T, except that t is known to be int. For example, we could write:
```
module Ints : (Arith with type t = int) = struct
  (* all of Ints as before *)
end
```
**Now both Ints.(one + one) and Ints.(1 + 1) are legal.**