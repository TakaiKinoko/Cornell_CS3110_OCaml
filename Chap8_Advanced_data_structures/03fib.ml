type 'a stream =
     Cons of 'a * (unit -> 'a stream)


let hd (Cons (hd, _)) = hd

let tl (Cons (_, tf)) = tf ()

let rec take n s = 
    if n = 0 then []
    else hd s::take (n-1) (tl s)

let rec sum (Cons (h1, tf1)) (Cons (h2, tf2)) = 
    Cons(h1+h2, fun () -> sum (tf1 ()) (tf2 ()))

let rec fibs = 
    Cons(1, fun () -> 
        Cons(1, fun () ->
            sum fibs (tl fibs)))

let () = 
    List.iter (fun x -> print_int x; print_string " ") (take 10 fibs);
    print_newline()