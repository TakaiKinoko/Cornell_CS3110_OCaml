module type ComplexSig = sig
  val zero : float*float
  val add : float*float -> float*float -> float*float
end

module Complex = struct
  let zero = 0., 0.
  let add (r1,i1) (r2,i2) = r1 +. r2, i1 +. i2
end

(** Improve the above code by adding type t = float*float to both the structure and signature. 
    Show how the signature can be written more tersely because of the type synonym. *)
module type ComplexSig' = sig
    type t 
    val zero : t
    val add : t -> t -> t
end

module Complex' = struct
    type t = float * float
    let zero = 0., 0. 
    let add (r1, i1) (r2, i2) = r1 +. r2, i1 +. i2
end

