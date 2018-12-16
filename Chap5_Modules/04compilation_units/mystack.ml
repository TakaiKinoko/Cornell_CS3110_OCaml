(*notice that there is no struct..end around it or any module*)

type 'a t = 'a list

let empty = []
let is_empty s = (s = [])

let push x s = x :: s

let peek = function
  | [] -> failwith "Empty"
  | x::_ -> x

let pop = function
  | [] -> failwith "Empty"
  | _::xs -> xs