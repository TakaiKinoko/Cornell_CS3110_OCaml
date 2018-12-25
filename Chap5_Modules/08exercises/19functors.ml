(** 19. Write a module type ToString that specifies a signature 
    with an abstract type t and a function to_string : t -> string. *)

module type ToString = sig
    type t
    val to_string : t -> string
end

(** 20. Write a functor Print that takes as input a module named M of type ToString. 
    The structure returned by your functor should have exactly one value in it, print, 
    which is a function that takes a value of type M.t and prints a string representation of that value. *)
module Print (M: ToString) = struct 
    let print v = print_endline(M.to_string v)
end

(** 21. Create a module named PrintInt that is the result of applying the functor Print to a new module Int. 
    You will need to write Int yourself. 
    The type Int.t should be int. Hint: do not seal Int. *)
module Int: ( ToString with type t = int) = struct 
    type t = int
    let to_string = string_of_int 
end

module PrintInt = Print(Int) 

(** test *)
let myint = PrintInt.print 3

(** 22. Create a module named PrintString that is the result of applying the functor Print to a new module MyString. 
    You will need to write MyString yourself. Hint: do not seal MyString.
    Experiment with PrintString in utop. Use it to print the value of a string.*)
module MyString: ( ToString with type t = string) = struct
    type t = string
    let to_string v = v 
end

module PrintString = Print(MyString)

(** test *)
let () = PrintString.print "Still foggy as to how adding this extra layer helps...\nBut I'm sure the aha moment will come ;)"

(** 23. meh *)

(** 24. The PrintString module you created above supports just one operation: print. 
    It would be great to have a module that supports all the String module functions in addition to that print operation, 
    and it would be super great to derive such a module without having to copy any code.
    Define a module StringWithPrint. It should have all the values of the built-in String module. 
    It should also have the print operation, which should be derived from the Print functor rather than being copied code.
    Hint: use two include statements. *)
module StringWithPrint = struct 
    include String
    include PrintString
end 

(** test *)
let () = 
    let open StringWithPrint in 
    print "signature checked in utop";
    print (uppercase_ascii "pretty useful way to reuse code!!")