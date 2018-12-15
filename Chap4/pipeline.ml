let (|>) x f = f x

(** |> can be used as infix op *)
let () = print_endline(string_of_int (5 |> (fun x -> 2*x)))