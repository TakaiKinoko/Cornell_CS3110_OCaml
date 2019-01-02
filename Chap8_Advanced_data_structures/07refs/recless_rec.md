## recursive function without rec

### syntax
* with rec
```
let rec f x = 
    ...... some code including a recursive call [f y] from some argument [y] ... 
```

* without rec
```
let f0 = ref (fun x -> x)

let f x = 
    ... replace [f y] with [!f0 y] ...

let () = f0 := f
```
What's happening here is sometimes called "tying the recursive knot": we update the reference to f0 to point to f , such that when f dereferences f0 , it gets itself back! The initial function to which we made f0 point (in this case the identity function) doesn't really matter; it's just there as a placeholder until we tie the knot.