signature STACK = 
sig
  type 'a Stack

  val empty   : 'a Stack
  val isEmpty : 'a Stack -> bool
  val cons    : 'a * 'a Stack -> 'a Stack
  val head    : 'a Stack -> 'a
  val tail    : 'a Stack -> 'a Stack
end

structure list: STACK =
struct
  type 'a Stack = 'a list
  val empty = []

  fun isEmpty s = null s
  fun cons (x, s) = x::s
  fun head s = hd s
  fun tail s = tl s
end

structure CustomStack : STACK = 
struct
  datatype 'a Stack = NIL | CONS of 'a * 'a Stack
  exception EMPTY

  val empty = NIL
  fun isEmpty NIL = true | isEmpty _ = false
  fun cons (x, s) = CONS (x, s)
  fun head NIL = raise EMPTY
    | head (CONS (x, s)) = x
  fun tail NIL = raise EMPTY
    | tail (CONS (x, s)) = s
end

(* Exercise 2.1 *)
fun suffixes [] = [[]]
  | suffixes (x::xs) = (x::xs)::(suffixes xs)

signature SET =
sig
  type Elem
  type Set

  val empty   : Set
  val insert  : Elem * Set -> Set
  val member  : Elem * Set -> bool
end

signature ORDERED =
  (* a totally ordered type and its comparison functions *)
sig
  type T

  val eq  : T * T -> bool
  val lt  : T * T -> bool
  val leq : T * T -> bool
end

structure OrderedInt: ORDERED =
struct
	type T = int

	fun eq (x, y) = (x = y)

	fun lt (x, y) = x < y

	fun leq (x, y) = x <= y
end

functor UnbalancedSet (Element: ORDERED): SET =
struct
  type Elem = Element.T
  datatype Tree = E | T of Tree * Elem * Tree
  type Set = Tree

  val empty = E

  fun member (x, E) = false
    | member (x, T(a, y, b)) =
      if Element.lt (x, y) then member (x, a)
      else if Element.lt (y, x) then member (x, b)
      else true

  fun insert (x, E) = T (E, x, E)
    | insert (x, s as T (a, y, b)) =
      if Element.lt (x, y) then T (insert (x, a), y, b)
      else if Element.lt (y, x) then T (a, y, insert (x, b))
      else s
end

(* Fix from: http://www.mlton.org/ObjectOrientedProgramming *)
functor AnderssonSet (Element: ORDERED): SET =
struct
  type Elem = Element.T
  datatype Tree = E | T of Tree * Elem * Tree
  type Set = Tree

  val empty = E

  fun member (x, t) = let
		fun member' (x, e, E) = Element.eq (x, e)
    	| member' (x, e, T(a, y, b)) =
      	if Element.lt (x, y) then member' (x, y, a)
      	else member' (x, e, b)
		in
			case t of
				E => false
			| T(a, y, b) => member' (x, y, t)
		end

  fun insert (x, E) = T (E, x, E)
    | insert (x, s as T (a, y, b)) =
      if Element.lt (x, y) then T (insert (x, a), y, b)
      else if Element.lt (y, x) then T (a, y, insert (x, b))
      else s
end
