module type Dictionary = sig 
    type ('k, 'v) t
    (* The empty dictionary *)
    val empty : ('k, 'v) t
    
    (* [insert k v d] produces a new dictionary [d'] with the same mappings 
   * as [d] and also a mapping from [k] to [v], even if [k] was already 
   * mapped in [d]. *)
    val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
    
    (* [lookup k d] returns the value associated with [k] in [d].  
   * raises:  [Not_found] if [k] is not mapped to any value in [d]. *)
    val lookup : 'k -> ('k, 'v) t -> 'v
end

module AssocListDict : Dictionary = struct 
    type ('k, 'v) t = ('k * 'v) list

    let empty = []

    let insert k v d = (k, v)::d

    let lookup k d = List.assoc k d

end