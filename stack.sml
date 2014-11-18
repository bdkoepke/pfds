signature STACK = 
sig
	type 'a Stack
	val empty		: 'a Stack
	val isEmpty	: 'a Stack -> bool
	val cons		: 'a * 'a Stack -> 'a Stack
	val head		: 'a Stack -> 'a
	val tail		: 'a Stack -> 'a Stack
end
