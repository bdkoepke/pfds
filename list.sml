use "stack.sml";

structure list: STACK =
struct
	type 'a Stack = 'a list
	val empty = []
	fun isEmpty s = null s
	fun cons (x, s) = x::s
	fun head s = hd s
	fun tail s = tl s
end
