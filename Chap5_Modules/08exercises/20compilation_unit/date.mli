(* type date = { month:int; day:int; }   -- concrete type *)
type date  (** abstract type *)
val make_date : int -> int -> date
val get_month : date -> int
val get_day : date -> int
val to_string : date -> string