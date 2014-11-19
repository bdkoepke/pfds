fun factorial n =
  if n = 0 then 1 else n * factorial (n-1)

fun factorial 0 = 1
  | factorial n = n * factorial (n - 1)

val rec factorial =
  fn n => case n of 0 => 1
    | n => n * factorial (n - 1)

val rec factorial = fn 0 => 1 | n => n * factorial (n - 1)

fun factorial n = let
  fun lp (0, acc) = acc
    | lp (m, acc) = lp (m - 1, m * acc)
  in
    lp (n, 1)
  end

(* type synonym for points in the plane *)
type loc = real * real

(* function computing distance between two points *)
fun distance ((x0, y0), (x1, y1)) = let
  val dx = x1 - x0
  val dy = y1 - y0
  in
    Math.sqrt (dx * dx + dy * dy)
  end

(* computes the area of a triangle with the given corners as per heron's formula *)
fun heron (a, b, c) = let
  val ab = distance (a, b)
  val bc = distance (b, c)
  val ac = distance (a, c)
  val perim = ab + bc + ac
  val s = perim / 2.0
  in
    Math.sqrt (s * (s - ab) * (s - bc) * (s - ac))
  end

datatype shape
  = Circle    of loc * real       (* center and radius *)
  | Square    of loc * real       (* upper-left corner and side length; axis-aligned *)
  | Triangle  of loc * loc * loc  (* corners *)

fun area (Circle (_, r)) = 3.14 * r * r
  | area (Square (_, s)) = s * s
  | area (Triangle (a, b, c)) = heron (a, b, c) (* see above *)

fun area shape = 
  case shape
    of Circle (_, r) => 3.14 * r * r
      | Square (_, s) => s * s
      | Triangle (a, b, c) => heron (a, b, c)

fun center (Circle (c, _)) = c
  | center (Square ((x, y), s)) = (x + s / 2.0, y + s / 2.0)

fun hasCorners (Circle _) = false
  | hasCorners _ = true

fun applyToBoth f x y = (f x, f y)

fun constantFn k = let
    fun const anything = k
  in
    const
  end

fun constantFn k = (fn anything => k)

fun compose (f, g) = let
    fun h x = f (g x)
  in
    h
  end

fun compose (f, g) = (fn x => f (g x))

fun map _ [] = []
  | map f (x::xs) = f x :: map f xs

fun map f xs = let
    fun m ([], acc) = List.rev acc
      | m (x::xs, acc) = m (xs, f x :: acc)
  in
    m (xs, [])
  end

exception Undefined
  fun max [x] = x
    | max (x::xs) = let val m = max xs in if x > m then x else m end
    | max [] = raise Undefined
  fun main xs = let
    val msg = (Int.toString (max xs)) handle Undefined => "empty list....there is no max!"
  in
    print (msg ^ "\n")
  end

exception Zero
  fun listProd ns = let
    fun p [] = 1
      | p (0::_) = raise Zero
      | p (h::t) = h * p t
    in
      (p ns) handle Zero => 0
    end

signature QUEUE =
sig
  type 'a queue
  exception QueueError
  val empty     : 'a queue
  val isEmpty   : 'a queue -> bool
  val singleton : 'a -> 'a queue
  val insert    : 'a * 'a queue -> 'a queue
  val peek      : 'a queue -> 'a
  val remove    : 'a queue -> 'a * 'a queue
end

structure TwoListQueue :> QUEUE =
struct
  type 'a queue = 'a list * 'a list
  exception QueueError

  val empty = ([],[])

  fun isEmpty ([],[]) = true
    | isEmpty _ = false

  fun singleton a = ([], [a])

  fun insert (a, ([], [])) = ([], [a])
    | insert (a, (ins, outs)) = (a::ins, outs)

  fun peek (_,[]) = raise QueueError
    | peek (ins, a::outs) = a

  fun remove (_,[]) = raise QueueError
    | remove (ins, [a]) = (a, ([], rev ins))
    | remove (ins, a::outs) = (a, (ins,outs))
end

functor BFS (structure Q: QUEUE) = (* after Okasaki, ICFP, 2000 *)
  struct
    datatype 'a tree
      = E
      | T of 'a * 'a tree * 'a tree
    fun bfsQ (q : 'a tree Q.queue) : 'a list =
      if Q.isEmpty q then []
      else let
          val (t, q') = Q.remove q
        in case t
          of E => bfsQ q'
            | T (x, l, r) => let
                val q'' = Q.insert (r, Q.insert (l, q'))
              in
                x :: bfsQ q''
              end
          end
      fun bfs t = bfsQ (Q.singleton t)
    end

fun ins (n, []) = [n]
    | ins (n, ns as h::t) = if (n<h) then n::ns else h::(ins (n, t))
  val insertionSort = List.foldr ins []

fun ins' << (num, nums) = let
    fun i (n, []) = [n]
      | i (n, ns as h::t) = if <<(n,h) then n::ns else h::i(n, t)
  in
    i (num, nums)
  end
  fun insertionSort' << = List.foldr (ins' <<) []

(* Split list into two near-halves, returned as a pair.
 * The "halves" will either be the same size,
 * or the first will have one more element than the second.
 * Runs in O(n) time, where n = |xs|. *)
local
  fun loop (x::y::zs, xs, ys) = loop (zs, x::xs, y::ys)
    | loop (x::[], xs, ys) = (x::xs, ys)
    | loop ([], xs, ys) = (xs, ys)
  in
    fun split ns = loop (List.rev ns, [], [])
  end

(* Merge two ordered lists using the order lt.
 * Pre: the given lists xs and ys must already be ordered per lt.
 * Runs in O(n) time, where n = |xs| + |ys|. *)
fun merge lt (xs, ys) = let
  fun loop (out, left as x::xs, right as y::ys) =
    if lt (x, y) then loop (x::out, xs, right)
      else loop (y::out, left, ys)
        | loop (out, x::xs, []) = loop (x::out, xs, [])
        | loop (out, [], y::ys) = loop (y::out, [], ys)
        | loop (out, [], []) = List.rev out
  in
    loop ([], xs, ys)
  end

(* Sort a list in according to the given ordering operation lt.
 * Runs in O(n log n) time, where n = |xs|.
 *)
fun mergesort lt xs = let
  val merge' = merge lt
    fun ms [] = []
      | ms [x] = [x]
      | ms xs = let
        val (left, right) = split xs
        in
          merge' (ms left, ms right)
        end
  in
    ms xs
  end

fun quicksort << xs = let
  fun qs [] = []
    | qs [x] = [x]
    | qs (p::xs) = let
    val (less, more) = List.partition (fn x => << (x, p)) xs
    in
      qs less @ p :: qs more
    end
  in
    qs xs
  end

exception Err

datatype ty
  = IntTy
  | BoolTy

datatype exp
  = True
  | False
  | Int of int
  | Not of exp
  | Add of exp * exp
  | If of exp * exp * exp

fun typeOf (True) = BoolTy
  | typeOf (False) = BoolTy
  | typeOf (Int _) = IntTy
  | typeOf (Not e) = if typeOf e = BoolTy then BoolTy else raise Err
  | typeOf (Add (e1, e2)) = 
  if (typeOf e1 = IntTy) andalso (typeOf e2 = IntTy) then IntTy else raise Err
    | typeOf (If (e1, e2, e3)) = 
    if typeOf e1 <> BoolTy then raise Err
    else if typeOf e2 <> typeOf e3 then raise Err
    else typeOf e2

fun eval (True) = True
  | eval (False) = False
  | eval (Int n) = Int n
  | eval (Not e) = 
    (case eval e
    of True => False
      | False => True
      | _ => raise Fail "type-checking is broken")
      | eval (Add (e1, e2)) = let
      val (Int n1) = eval e1
      val (Int n2) = eval e2
      in
        Int (n1 + n2)
      end
      | eval (If (e1, e2, e3)) = 
        if eval e1 = True then eval e2 else eval e3

fun chkEval e = (ignore (typeOf e); eval e) (* will raise Err on type error *)

fun fact n  : IntInf.int =
  if n=0 then 1 else n * fact(n - 1)

val () =
  print (IntInf.toString (fact 120) ^ "\n")

(* fun d delta f x =
    (f (x + delta) - f (x - delta)) / (2.0 * delta);
  val d = fn  : real -> (real -> real) -> real -> real

fun haar l = let
  fun aux [s] [] d = s  :: d
    | aux [] s d = aux s [] d
    | aux (h1::h2::t) s d = aux t (h1+h2  :: s) (h1-h2  :: d)
    | aux _ _ _ = raise Empty
  in  
    aux l [] []
  end
  val haar = fn  : int list -> int list*)
