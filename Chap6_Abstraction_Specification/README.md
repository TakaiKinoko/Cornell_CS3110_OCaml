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

## specifications for functions
* **Returns Clause** (postcondition) 
   * 
    ```
    (* returns: [sqr x] is the square root of [x]. *)
    ```
    in OCamldoc documentation, we would typically leave out the returns:, and simply write the returns clause as the first sentence of the comment:
    ```
    (** [sqr x] is the square root of [x]. *)

    ```
    ```
    (** [find lst x] is the index of [x] in [lst], starting from zero. *)
    ```
    * For numerical programming, we should probably add some information about how accurate it is.
    ```
    (** [sqr x] is the square root of [x].  Its relative accuracy is no worse 
    than 1.0*10^-6. *)
    ```
* A good function specification is complete with respect to the possible inputs; it provides the client with an understanding of what inputs are allowed and what the results will be for allowed inputs. e.g **partial function**, sqr root is only defined over part of its domain.
    * **Requires Clause** (precondition): A straightforward approach is to restrict the domain so that it is clear the function cannot be legitimately used on some inputs.
    ```
    (** [sqr x] is the square root of [x]. Its relative accuracy is no worse 
    than 1.0x10^-6.  Requires: [x >= 0] *)
    ```
        * pro: free to design an algorithm without the constraint of having to check for invalid input parameters
        * con: difficult to debug if the function is called improperly
    * **Raises Clause**