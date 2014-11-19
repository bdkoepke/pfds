(* Exercise 2.1 *)
fun suffixes [] = [[]]
	| suffixes (x::xs) = (x::xs)::(suffixes xs)
