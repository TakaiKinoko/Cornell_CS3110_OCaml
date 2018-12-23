### Red-Black tree
Red-black trees are relatively simple balanced binary tree data structure. The idea is to strengthen the representation invariant so a tree has height logarithmic in the number of nodes  n . To help enforce the invariant, we color each node of the tree either red or black. Where it matters, we consider the color of an empty tree to be black.

```
type color = Red | Black
type 'a rbtree = 
    |Leaf
    |Node of color * 'a rbtree * 'a rbtree
```

* There are no two adjacent red nodes along any path.
* Every path from the root to a leaf has the same number of black nodes. This number is called the black height (BH) of the tree.

* If a tree satisfies these two conditions, it must also be the case that every subtree of the tree also satisfies the conditions. If a subtree violated either of the conditions, the whole tree would also.

* Additionally, by convention the root of the tree is colored black. This does not violate the invariants, but it also is not required by them.

With these invariants, the longest possible path from the root to an empty node would alternately contain red and black nodes; therefore it is at most twice as long as the shortest possible path, which only contains black nodes. The longest path cannot have a length greater than twice the length of the paths in a perfect binary tree, which is  O(lg n) . Therefore, the tree has height O(lg n) and the operations are all asymptotically logarithmic in the number of nodes.

