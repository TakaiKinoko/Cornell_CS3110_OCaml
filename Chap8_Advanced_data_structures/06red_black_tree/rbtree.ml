type color = Red | Black
type 'a rbtree = 
    | Leaf
    | Node of color * 'a rbtree * 'a rbtree

