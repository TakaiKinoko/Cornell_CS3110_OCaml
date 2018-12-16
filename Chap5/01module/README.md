### Module Syntax
```
module ModuleName = struct 
    (* definitions *)
end
```

structure is anonymous until it's bound to a name:  
```
struct (* definitions *) end
```

The implementation of a module can contain *type* definitions, *exception* definitions, *let* definitions, *open* statements, as well as some other things 