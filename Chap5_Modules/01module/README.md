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

The implementation of a module can contain **type** definitions, **exception** definitions, **let** definitions, **open** statements, as well as some other things 

### Module Type
Module types let us describe groups of related modules. The syntax for defining a module type is:
```
module type ModuleTypeName = sig
    (* declarations *)
end 
```
notice that signature contains declartions, not definitions. 


To define a module with a type
```
module ModuleName : ModuleTypeName = struct
    (* definitions *)
end
```