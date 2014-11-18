(* Exercise 2.1 *)
fun suffixes nil = nil
	| suffixes (x::xs) = (x::xs)::(suffixes xs)
