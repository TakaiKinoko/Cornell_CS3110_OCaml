### functional data structure
* A functional data structure is one that does not make use of any imperative features. That is, no operations of the data structure have any side effects.
* It has the property of being persistent: updating the data structure with one of its operations does not change the existing version of the data structure but instead produces a new version

### abstract types 
* The type **'a stack** in module type **Stack** is abstract: the Stack module type says that there is a type name 'a stack in any module that implements the module type, but it does not say what that type is defined to be. Once we add the : Stack module type annotation to ListStack, its 'a stack type also becomes abstract. **Outside of the module, no one is allowed to know that 'a stack and 'a list are synonyms.**

* A module that implements a module type must specify concrete types for the abstract types in the signature and define all the names declared in the signature. **Only declarations in the signature are accessible outside of the module.** 
