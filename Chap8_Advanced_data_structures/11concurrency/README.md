### approaches in achieving concurrency
* multi-programming
* parallelism (in multi-core systems)

### chanllenges
* race condition
* The most fundamental challenge is that concurrency makes the execution of a program become **nondeterministic**: the order in which operations occur cannot necessarily be known ahead of time. Race conditions are an example of nondeterminism.

### functional programming 
* Purely functional programs make nondeterminism easier to reason about, because evaluation of an expression always returns the same value no matter what. 

### threads
* a useful abstraction-- a single sequential computation
* concretely, a thread is a set of values that are loaded into the registers of a processor. 

### promisses
* In the functional programming paradigm, one of the best known abstractions for concurrency is **promises** (aka. *futures, deferreds, and delayeds*). 
* All those names refer to the idea of a computation that is **not yet finished**: it has promised to eventually produce a value in the future, but the completion of the computation has been deferred or delayed. There may be many such values being computed concurrently, and when the value is finally available, there may be computations ready to execute that depend on the value.
* adoption in other languages: 
    * JS's *async* keyword -- causes a function to return a promise 
    *await* keyword -- waits for a promise to finish computing
* OCaml: **Async** and **Lwt**