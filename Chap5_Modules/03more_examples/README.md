### use modules in utop
e.g. to use "dict.ml", type the following in utop
```
# #use "dict.ml";;
# open AssocListDict;;
# let d = insert 1 "one" empty;;
```

### abstract v.s. concrete type from a module
* If the module AssocListDict isn't associated with the type Dictionary, its type is concrete therefore can be known to the client. 

* But once indicated that the module has type Dictionary, the type AssocListDict.t has become abstract. Clients of the module are no longer permitted to know that it is implemented with a list.

### benefit of having abstract type
With encapsulation provided, if we later wanted to change the representation, we could safely do so. The client would never know!