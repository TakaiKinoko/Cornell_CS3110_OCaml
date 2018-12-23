# 5.18 ~5.21 unfinished!

### includes -- enables code reuse
* **includes** enables a structure to include all the values defined by another structure, or a signature to include all the names declared by another signature.

### different from dynamic dispatch
One misconception to watch out for in the ListSetDups.ml example is that the above example does not *replace* the original implementation of elts. If any code inside ListSetDups called that original implementation, it still would invoke ListSetDupsExtended. Why? Remember the semantics of modules: all definitions are evaluated from top to bottom, in order. So the new definition of elts above won't come into use until the very end of evaluation. This differs from what you might expect from object-oriented languages like Java, which use a language feature called dynamic dispatch to figure out which implementation to invoke.
