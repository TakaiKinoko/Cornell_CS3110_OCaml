## specification
* what is it: a contract between the client and the implementer
* where is it: often in .mli files for a module

* **precondition** inform what the client must guarantee about inputs they pass in and what the implementer may assume about those inputs
* **postcondition** inform what the client may assume about the outputs they receive and what the implementer must guarantee about those outputs.

* design goals: **sufficiently restrictive** and **sufficiently general**

### difficulty
the compiler does nothing to check the correctness of a specification. there's no type system or warnings for them.

### abstraction by specification
meaning: they reveal certain information about the behavior of a module without disclosing all the details of the module's implementation.
* benefits: 
    1. locality -- A module can be understood without needing to examine its implementation. This locality is critical in implementing large programs
    1. modifiability -- Modules can be reimplemented without changing the implementation of other modules or functions. 
* abstraction barrier: The specification forms an abstraction barrier that protects the implementer from the client and vice versa. Making assumptions about the implementation that are not guaranteed by the specification is known as violating the abstraction barrier. 