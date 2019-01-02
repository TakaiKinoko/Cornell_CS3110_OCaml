### ref
* ref is parameterized type constructor. A t ref , for any type t , is a reference to a memory location that is guaranteed to contain  a value of type t .  
*  As usual we should **read should a type from right to left**: t ref means a reference to a t .
* **dereference** a ref: use ! operator 
* **assignment**: use := operator. Note that the ref still points to the **same memory location**, it's the content of it that's mutable.
* the return type of an assignment statement is unit. 

#### aliasing
* with refs comes aliasing. Two refs could point to the same memory location.

#### memory safety
* **ocaml v.s. C** In C: programmers can directly write memory addresses and do arithmetic on pointers, which makes it possible to interface with hardware and build OS with C. In OCaml, locations are values that can be passed to and returned from functions. But there's no way to directly write a location.

### semicolon operator: sequence effect
* with mutability (side effects), the sequence of execution matters for computation.
* syntax:  e1; e2 
* semantics: the value of the whole sequence is the value that e2 is evaluated to.

#### suppress warning:
* possible scenario: The typing rule for semicolon is designed to prevent programmer mistakes. For example, a programmer who writes 2+3; 7 probably didn't mean to: there's no reason to evaluate 2+3 then throw away the result and instead return 7 . The compiler will give you a warning if you violate this particular typing rule.
* **to suppress warning**: use the function: ignore: 'a -> unit (in stdlib). 
ignore(2+3); 7 will compile w/o a warning.

#### define ignore: 
let ignore _ = ()