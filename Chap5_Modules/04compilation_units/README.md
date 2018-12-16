### compilation units
A compilation unit is a pair of OCaml source files in the same directory. They share the same base name, call it x, but their extensions differ: one file is **x.ml**, the other is **x.mli**. The file **x.ml** is called the implementation, and **x.mli** is called the interface.

### in effect
complie foo.ml will have the same effect as defining the module Foo as follows: 
```
module Foo : sig
  val x : int
  val f : int -> int -> int
end = struct
  let x = 0
  let y = 12
  let f x y = x + y
end
```

### in general
when the compiler encounters a compilation unit, it treats them as defining a module and a signature like this:
```
module Foo : sig (* insert contents of foo.mli here *) end = struct
  (* insert contents of foo.ml here *)
end
```

The standard library uses compilation units to implement most of the modules you have been using so far, like List and String

### comments
The comments that go in an interface file vs. an implementation file are different. **Interface files** will be read by clients of an abstraction, so the comments that go there are for them. These will generally be specification comments describing how to use the abstraction, the preconditions for calling its functions, what exceptions they might raise, and perhaps some notes on what algorithms are used to implement operations. The standard library's List module contains many examples of these kinds of comments.

**Implementation files** will be read by programmers and maintainers of an abstraction, so the comments that go there are for them. These will be comments about how the representation type is used, how the code works, important internal invariants it maintains, and so forth.


### compile source 
(note that all we need is the .cmo file so we request it to be built instead of the .byte file):
```
$ ocamlbuild mystack.cmo
```
this will generate a mystack.cmo in the "_build" directory

### use cmo in utop
launch utop and: 
```
# #directory "_build";;
# #load "mystack.cmo";;
# Mystack.empty;;
- : 'a Mystack.t = <abstr>
```