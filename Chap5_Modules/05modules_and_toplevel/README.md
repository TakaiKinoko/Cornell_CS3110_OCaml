### loading compiled modules
compile mods.ml with 
```
ocamlbuild mods.byte
```
inside *_build* there's **mods.cmo** which is **compiled module object**, aka bytecode. 

To use it in toplevel (working directory should be where _build is of course)
```
# #directory "_build";;
# #load "mods.cmo";;
```

### initialize toplevel with modules 
create a file in the working directory **.ocamlinit**
```
#directory "_build";;
#load "mods.cmo";;
open Mods
```
Everything in .ocamlinit will be processed by utop when it loads.

### requiring libraries
* including libraries in .ml
e.g. 
```
open OUnit2
let test = "testb" >:: (fun _ -> assert_equal "bigred" b)
```
compile with **ocamlbuild -pkg oUnit mods.byte** will work

* load a module that includes libraries into utop using .ocamlinit
add 
```
#require "oUnit";;
```
to **.ocamlinit**

### dependencies
* build system v.s. toplevel
When compiling a file, the build system automatically figures out which other files it depends on, and recompiles those as necessary. The toplevel, however, is not as sophisticated: you have to make sure to load all the dependencies of a file.
* build system -- compile mods2.ml which depends on mods.ml
```
ocamlbuild -pkg oUnit mods2.byte
```
* toplevel
suppose .ocamlinit contains exactly the following: 
```
#directory "_build";;
#require "oUnit";;
```
now if restart utop and try to load mods2.cmo, you will get an error:
```
# #load "mods2.cmo";;
Error: Reference to undefined global `Mods'
```
The problem is that the toplevel does not automatically load the modules that Mods2 depends upon. 
* solotion 1:
manually load dependencies into toplevel
```
# #load "mods.cmo";;
# #load "mods2.cmo";;
```
* solution 2, better: 
```
# #load_rec "mods2.cmo"
```
