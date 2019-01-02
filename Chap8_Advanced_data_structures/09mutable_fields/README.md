### Mutable fields of a record
* declaration syntax: 
    ```
    {...; mutable <field>: <type>; ...}
    ```
* update a mutable field: 
    ```
    <record>.<field> <- <value>
    ```

### Refs as mutable fields
* refs are actually implemented as mutable fields. 
```
type 'a ref = {mutable contents: 'a;}
```
* ref operators are equivalent to simple functions
```
val ref : 'a -> 'a ref

val (!) : 'a ref -> 'a

val (:=) : 'a ref -> 'a -> unit
``` 
* The reason we say "equivalent" is that those functions are actually implemented not in OCaml but in the **OCaml run-time, which is implemented mostly in C**. But the functions do behave the same as the OCaml source given above in comments.


### Weakly polymorphic type
see the end of mutable_stack.ml