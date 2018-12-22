### BST invariant
* For any node n, every node in the left subtree of n has a value less than n's value, and every node in the right subtree of n has a value greater than n's value.

### performance analysis
* **mem** takes O(h), because every recursive call descends one level in the tree. What's the worst-case height of a tree? It occurs with a tree of  n  nodes all in a single long branch—imagine adding the numbers 1,2,3,4,5,6,7 in order into the tree. So the worst-case running time of mem is still O(n), where  n  is the number of nodes in the tree.

### good shape 
What is a good shape for a tree that would allow for fast lookup? A perfect binary tree has the largest number of nodes  n  for a given height  h , which is  n=2^(h+1)−1 . Therefore  h=log(n+1)−1 , which is  O(logn) .

If a tree with  n  nodes is kept balanced, its height is  O(logn) , which leads to a lookup operation running in time  O(logn) .
