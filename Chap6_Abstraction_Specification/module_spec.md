## Specification of Modules
#### purpose:
not for clients (they can only read interface), but to explain the implementation to other implementers or maintainers of the module. 

#### what's inappropriate: 
* copy the specifications of functions found in the module interface into the module implementation.
* why? Copying runs the risk of introducing inconsistency as the program evolves, because programmers don't keep the copies in sync. Copying code and specifications is a major source (if not the major source) of program bugs. In any case, implementers can always look at the interface for the specification.

#### implementation comments categorization
1. a module implementation may define new types and functions that are purely **internal** to the module. If their significance is not obvious, these types and functions should be documented in much the same style that we have suggested for documenting interfaces.
1. **data abstraction** 
