let b = "bigred"
let inc x = x+1
module M = struct
  let y = 42
end

open OUnit2
let test = "testb" >:: (fun _ -> assert_equal "bigred" b)