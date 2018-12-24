(** 13. *)

type date = { month: int; day: int }

(** implement a map whose keys have type date 
    The behavior of your code in the exercises below is unspecified for invalid dates.*)

module Date = struct 
    type t = date
    let compare {month=month1; day=int1} {month=month2; day=int2} = 
        if month1 = month2 then Pervasives.compare int1 int2
        else Pervasives.compare month1 month2
end

(** 14. *)
module DateMap = Map.Make(Date)

type calendar = string DateMap.t   (* parameterize DateMap with type string, meaning in the map keys of type Date will be bound to strings*)

open DateMap

let bday_cal = empty |> add {month = 1; day = 17} "Dad" 
                     |> add {month = 6; day = 13} "Mom"
                     |> add {month = 8; day = 4} "Mochi"
                     |> add {month = 3; day = 25} "Me"

let month_to_string = function 
    | 1 -> "Jan"  
    | 2 -> "Feb"
    | 3 -> "Mar"
    | 4 -> "Apr"
    | 5 -> "May" 
    | 6 -> "Jun" 
    | 7 -> "Jul"
    | 8 -> "Aug" 
    | 9 -> "Sep" 
    | 10 -> "Oct" 
    | 11 -> "Nov" 
    | 12 -> "Dec"
    | _ -> failwith "Invalid month"

let rec print_bd_cal = function 
    | [] -> ()
    | ({month=month; day=day}, s)::tl -> 
        print_endline(s^"'s Birthday is "^month_to_string month^" "^string_of_int day);
        print_bd_cal tl

let () = print_bd_cal (bindings bday_cal)


(** 15. *)
let print_calendar = 
    iter (fun ky v -> print_endline(v^"'s Birthday is "^month_to_string ky.month^" "^string_of_int ky.day);) 

let () = 
    print_endline("\nUsing iter: ");
    print_calendar bday_cal


(** 16 is in Char_Map *)

(** 17 *)
let first_after cal ky = 
    snd (find_first (fun k -> Date.compare k ky > 0) cal)

(** test *)
let () = 
    print_endline("testing first_after");
    print_endline(first_after bday_cal {month=3; day= 1});
    print_endline(first_after bday_cal {month=1; day= 1});
    print_endline(first_after bday_cal {month=1; day= 17});
    print_endline(first_after bday_cal {month=3; day= 26});
    print_endline(first_after bday_cal {month=6; day= 13})

