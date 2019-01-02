### specification
* what is it: a contract between the client and the implementer
* where is it: often in .mli files for a module

* **precondition** inform what the client must guarantee about inputs they pass in and what the implementer may assume about those inputs
* **postcondition** inform what the client may assume about the outputs they receive and what the implementer must guarantee about those outputs.

* design goals: **sufficiently restrictive** and **sufficiently general**

### difficulty
the compiler does nothing to check the correctness of a specification. there's no type system or warnings for them.