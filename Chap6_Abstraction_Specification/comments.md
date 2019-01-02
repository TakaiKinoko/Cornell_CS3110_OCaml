## comments
* It is usually better to write a **paragraph-style comment** at the beginning of the function explaining how its implementation works
* Explicit points in the code that need to be related to that paragraph can then be marked with very brief comments, like **(* case 1 *)**.

### BAD example: verbose descriptive name
* 
    ```
    let number_of_zeros_in_the_list =
    fold_left (fun (accumulator:int) (list_element:int) ->
          accumulator + (if list_element=0 then 1 else 0)) 0 the_list
    in ...  
    ```
* fix: use a short and suggestive name (e.g., zeroes), and if necessary, add a comment at its declaration explaining the purpose of the variable.

### BAD practive: 
 * encode the type of the variable in its name, e.g. naming a variable count a name like 
    ```
    i_count 
    ```
    to show that it's an integer. 
 * fix: just write a type declaration.