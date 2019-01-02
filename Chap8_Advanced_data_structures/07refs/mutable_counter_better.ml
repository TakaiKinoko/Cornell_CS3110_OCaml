(* improvement 1: use library function incr: int ref -> unit
   improvement 2: hide counter so that clients of next_val can't directly change it *)

let next_val =  
    let counter = ref 0  (** Not that much different than binding counter to ref 0 outside the function except that now counter is no longer accessible outside of this function *)
    in fun () -> 
        incr counter;
        !counter

let next_val_wrong = fun () -> 
    let counter = ref 0    (** My thought: every time next_val_wrong is called, there'll be a new counter created in its stack frame, pointing to a heap location that stores a 0. When the frame is popped, the counter is popped with it. *)
    in incr counter;
        !counter

(** test *)
let () = 
    print_endline(string_of_int (next_val()));
    print_endline(string_of_int (next_val()));
    print_endline(string_of_int (next_val()));
    print_endline(string_of_int (next_val_wrong()));
    print_endline(string_of_int (next_val_wrong()));
    print_endline(string_of_int (next_val_wrong()));

(** The problem with next_val_wrong is that every time next_val_broken is called,the first thing it does is to evaluate ref 0 to a new location that is initialized to 0 . 
That location is then incremented to 1 , and 1 is returned. Every call to next_val_broken is thus allocating a new ref cell, whereas next_val allocates just one new ref cell. *)