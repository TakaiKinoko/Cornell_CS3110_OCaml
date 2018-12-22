### define fibonacci sequence using stream 
* Consider the Fibonacci sequence <1; 1; 2; 3; 5; 8; ...>. If we take the tail of it, we get <1; 2; 3; 5; 8; 13; ...>. If we sum those two streams, we get <2; 3; 5; 8; 13; 21; ...>. That's nothing other than the tail of the tail of the Fibonacci sequence. So if we were to prepend [1; 1] to it, we'd have the actual Fibonacci sequence. That's the intuition behind this definition.

* implementation: see 03fib.ml

* Unfortunately, it's highly inefficient. Every time we force the computation of the next element, it required recomputing all the previous elements, twice: once for fibs and once for tl fibs in the last line of the definition. By the time we get up to the 30th number, the computation is noticeably slow; by the time of the 100th, it seems to last forever.

### how to improve? -- laziness!