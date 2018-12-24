### functor
a functor is simply a "function" from structures to structures.

OCaml is stratified: structures are distinct from values, so functions from structures to structures cannot be written or used in the same way as functions from values to values.

### why functors?
In category theory, a category contains morphisms, which are a generalization of functions as we known them, and a functor is map between categories. Likewise, OCaml structures contain functions, and OCaml functors map from structures to structures.

### do functors have to return something similar?

No. In fact, a functor can return any structure it likes, perhaps something very different than its input structure

```
module type X = sig
  val x : int
end


module MakeY (M:X) = struct
  let y = 42
end
```

### functor syntax
(Module : Signature) is required because type inference doesn't support the signature of a functor input
```
module Functor (Module : Signature) = struct 
    ...
end
```

### anonymous functor
Much like functions, functors can be written anonymously

The following two syntaxes for functors are equivalent:
```
module F (M : S) = struct
  ...
end

module F = functor (M : S) -> struct
  ...
end
```

The second form uses the **functor keyword** to create an **anonymous functor**, like how the fun keyword creates an anonymous function.

### parameterize functors on multiple structures

functors can be parameterized on multiple structures:
```
module F (M1 : S1) ... (Mn : Sn) = struct
  ...
end
```
This is just syntactic sugar for a higher-order functor that takes a structure as input and returns an anonymous functor:
```
module F = functor (M1 : S1) -> ... -> functor (Mn : Sn) -> struct
  ...
end
```

### specify output type
the syntax is again similar to functions:
```
module F (M : Si) : So = struct
  ...
end
```
It's also possible to write the type annotation on the structure:
```
module F (M : Si) = (struct
  ...
end : So)
```
a similar syntax for functions that we just haven't used before:
```
let f x = (x+1 : int)
```

### write down the type of a functor
much like the syntax for writing down the type of a function.

```
functor (M: Si) -> So
```
### annotate a functor definition with a type
```
module F : functor (M : Si) -> So = 
  functor (M : Si) -> struct ... end
```

### Ocaml stdlib Map module
* The input to Make is OrderedType who must support a compare operation.
  Arguably this specification of 
  ```
  val compare: t-> t -> int
  ```
  is a missed opportunity for good design: the library designers could instead have defined a variant:
  ```
  type order = LT | EQ | GT
  ```
  the output type of compare should be order. 

* The Map module actually specifies a sharing constraint: type key =    Ord.t. That is, the output of Map.Make shares its key type with the type Ord.t. That enables keys to be compared with Ord.compare. The way that sharing constraint is specified is in the type of Make (which can be found in map.mli, the interface file for the map compilation unit):
  ```
  module Make : functor (Ord : OrderedType) -> (S with type key = Ord.t)
  ```

* **VARIANCE** The Map module actually specifies a variance on the representation type, writing +'a t instead of 'a t as we did above.

### OCaml Manual
https://caml.inria.fr/pub/docs/manual-ocaml/libref/Map.html
https://caml.inria.fr/pub/docs/manual-ocaml/libref/Map.Make.html
