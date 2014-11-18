Purely Functional Data Structures
---------------------------------

Examples and exercises from Purely Functional Data Structures by Okasaki.

Also need to look at this: https://cstheory.stackexchange.com/questions/1539/whats-new-in-purely-functional-data-structures-since-okasaki

Apparently:

2001: Ideal Hash Trees, and its 2000 predecessor, Fast And Space Efficient Trie Searches, by Phil Bagwell: Apparently used as a fundamental building block in Clojure's standard library.

2001: A Simple Implementation Technique for Priority Search Queues, by Ralf Hinze: a really simple and beautiful technique for implementing this important datastructure (useful, say, in the Dijkstra algorithm). The implementation is particularly beautiful and readable due to heavy use of "view patterns".

2002: Bootstrapping one-sided flexible arrays, by Ralf Hinze: Similar to Okasaki's random-access lists, but they can be tuned to alter the time tradeoff between cons and indexing.

2003: New catenable and non-catenable deques, by Radu Mihaescu and Robert Tarjan: A new take on some older work (by Kaplan and Tarjan) that Okasaki cites (The most recent version of Kaplan & Tarjan's work was published in 2000). This version is simpler in some ways.

2005: Maxiphobic heaps (paper and code), by Chris Okasaki: Presented not as a new, more efficient structure, but as a way to teach priority queues.

2006: Purely Functional Worst Case Constant Time Catenable Sorted Lists, by Gerth Stølting Brodal, Christos Makris, and Kostas Tsichlas: Answers an outstanding question of Kaplan and Tarjan by demonstrating a structure with O(lg n) insert, search, and delete and O(1) concat.

2008: Confluently Persistent Tries for Efficient Version Control, by Erik D. Demaine, Stefan Langerman, and Eric Price: Presents several data structures for tries that have efficient navigation and modification near the leaves. Some are purely functional. Others actually improve a long-standing data structure by Dietz et al. for fully persistent (but not confluently persistent or purely functional) arrays. This paper also presente purely functional link-cut trees, sometimes called "dynamic trees".

2010: A new purely functional delete algorithm for red-black trees, by Matt Might: Like Okasaki's red-black tree insertion algorithm, this is not a new data structure or a new operation on a data structure, but a new, simpler way to write a known operation.

2012: RRB-Trees: Efficient Immutable Vectors, by Phil Bagwell and Tiark Rompf: An extension to Hash Array Mapped Tries, supporting immutable vector concatenation, insert-at, and split in O(lg n) time, while maintaining the index, update, and insertion speeds of the original immutable vector.

Many other styles of balanced search tree. AVL, brother, rank-balanced, bounded-balance, and many other balanced search trees can be (and have been) implemented purely functionally by path copying. Perhaps deserving special mention are:

Biased Search Trees, by Samuel W. Bent, Daniel D. Sleator, and Robert E. Tarjan: A key element in Brodal et al.'s 2006 paper and Demaine et al.'s 2008 paper.
Infinite sets that admit fast exhaustive search, by Martín Escardó: Perhaps not a data structure per se.

Three algorithms on Braun Trees, by Chris Okasaki: Braun trees offer many stack operations in worst-case O(lg n). This bound is surpassed by many other data structures, but Braun trees have a cons operation lazy in its second argument, and so can be used as infinite stacks in some ways that other structures cannot.

The relaxed min-max heap: A mergeable double-ended priority queue and The KD heap: An efficient multi-dimensional priority queue, by Yuzheng Ding and Mark Allen Weiss: These happen to be purely functional, though this is not discussed in the papers. I do not think the time bounds achieved are any better than those that can be achieved by using finger trees (of Hinze & Paterson or Kaplan & Tarjan) as k-dimensional priority queues, but I think the structures of Ding & Weiss uses less space.

The Zipper, by Gérard Huet: Used in many other data structures (such as Hinze & Paterson's finger trees), this is a way of turning a data structure inside-out.

Difference lists are O(1) catenable lists with an O(n) transformation to usual cons lists. They have apparently been known since antiquity in the Prolog community, where they have an O(1) transformation to usual cons lists. The O(1) transformation seems to be impossible in traditional functional programming, but Minamide's hole abstraction, from POPL '98, discusses a way of allowing O(1) append and O(1) transformation within pure functional programming. Unlike the usual functional programming implementations of difference lists, which are based on function closures, hole abstractions are essentially the same (in both their use and their implementation) as Prolog difference lists. However, it seems that for years the only person that noticed this was one of Minamide's reviewers.

Uniquely represented dictionaries support insert, update, and lookup with the restriction that no two structures holding the same elements can have distinct shapes. To give an example, sorted singly-linked lists are uniquely represented, but traditional AVL trees are not. Tries are also uniquely represented. Tarjan and Sundar, in "Unique binary search tree representations and equality-testing of sets and sequences", showed a purely functional uniquely represented dictionary that supports searches in logarithmic time and updates in O(n‾‾√) time. However, it uses Θ(nlgn) space. There is a simple representation using Braun trees that uses only linear space but has update time of Θ(nlgn‾‾‾‾‾√) and search time of Θ(lg2n)

Many procedures for making data structures persistent, fully persistent, or confluently persistent: Haim Kaplan wrote an excellent survey on the topic. See also above the work of Demaine et al., who demonstrate a fully persistent array in O(m) space (where m is the number of operations ever performed on the array) and O(lglgn) expected access time.

1989: Randomized Search Trees by Cecilia R. Aragon and Raimund Seidel: These were discussed in a purely functional setting by Guy E. Blelloch and Margaret Reid-Miller in Fast Set Operations Using Treaps and by Dan Blandford and Guy Blelloch in Functional Set Operations with Treaps (code). They provide all of the operations of purely functional fingertrees and biased search trees, but require a source of randomness, making them not purely functional. This may also invalidate the time complexity of the operations on treaps, assuming an adversary who can time operations and repeat the long ones. (This is the same reason why imperative amortization arguments aren't valid in a persistent setting, but it requires an adversary with a stopwatch)

1997: Skip-trees, an alternative data structure to Skip-lists in a concurrent approach, by Xavier Messeguer and Exploring the Duality Between Skip Lists and Binary Search Trees, by Brian C. Dean and Zachary H. Jones: Skip lists are not purely functional, but they can be implemented functionally as trees. Like treaps, they require a source of random bits. (It is possible to make skip lists deterministic, but, after translating them to a tree, I think they are just another way of looking at 2-3 trees.)

1998: All of the amortized structures in Okasaki's book! Okasaki invented this new method for mixing amortization and functional data structures, which were previously thought to be incompatible. It depends upon memoization, which, as Kaplan and Tarjan have sometimes mentioned, is actually a side effect. In some cases (such as PFDS on SSDs for performance reasons), this may be inappropriate.

1998: Simple Confluently Persistent Catenable Lists, by Haim Kaplan, Chris Okasaki, and Robert E. Tarjan: Uses modification under the hood to give amortized O(1) catenable deques, presenting the same interface as an earlier (purely functional, but with memoization) version appearing in Okasaki's book. Kaplan and Tarjan had earlier created a purely functional O(1) worst-case structure, but it is substantially more complicated.

2007: As mentioned in another answer on this page, semi-persistent data structures and persistent union-find by Sylvain Conchon and Jean-Christophe Filliâtre

Phantom types are an old method for creating an API that does not allow certain ill-formed operations. A sophisticated use of them can be found in Oleg Kiselyov and Chung-chieh Shan's Lightweight Static Capabilities.

Nested types are not actually more recent than 1998 - Okasaki even uses them in his book. There are many other examples that are not in Okasaki's book; some are new, and some are old. They include:

Stefan Kahrs's Red-black trees with types (code)
Ross Paterson's AVL trees (mirror)
Chris Okasaki's From fast exponentiation to square matrices: an adventure in types
Richard S. Bird and Ross Peterson's de Bruijn notation as a nested datatype
Ralf Hinze's Numerical Representations as Higher-Order Nested Datatypes.
GADTs are not all that new, either. They are a recent addition to Haskell and some MLs, but they have been present, I think, in various typed lambda calculi since the 1970s.

2004-2010: Coq and Isabelle for correctness. Several people have used theorem provers to verify the correctness of purely functional data structures. Coq can extract these verifications to working code in Haskell, OCaml, and Scheme; Isabelle can extract to Haskell, ML, and OCaml.

Coq:
Pierre Letouzey and Jean-Christophe Filliâtre formalized red-black and AVL(ish) trees, finding a bug in the OCaml standard library in the process.
I formalized Brodal and Okasaki's asymptotically optimal priority queues.
Arthur Charguéraud formalized 825 of the 1,700 lines of ML in Okasaki's book.
Isabelle:
Tobias Nipkow and Cornelia Pusch formalized AVL trees.
Viktor Kuncak formalized unbalanced binary search trees.
Peter Lammich published The Isabelle Collections framework, which includes formalizations of efficient purely functional data structures like red-black trees and tries, as well as data structures that are less efficient when used persistently, such as two-stack-queues (without Okasaki's laziness trick) and hash tables.
Peter Lammich also published formalizations of tree automata, Hinze & Patterson's finger trees (with Benedikt Nordhoff and Stefan Körner), and Brodal and Okasaki's purely functional priority queues (with Rene Meis and Finn Nielsen).
René Neumann formalized binomial priority queues.
2007: Refined Typechecking with Stardust, by Joshua Dunfield: This paper uses refinement types for ML to find errors in SMLNJ's red-black tree delete function.

2008: Lightweight Semiformal Time Complexity Analysis for Purely Functional Data Structures by Nils Anders Danielsson: Uses Agda with manual annotation to prove time bounds for some PFDS.

The Soft Heap: An Approximate Priority Queue with Optimal Error Rate, by Bernard Chazelle: This data structure does not use arrays, and so has tempted first the #haskell IRC channel and later Stack Overflow users, but it includes delete in o(lg n), which is usually not possible in a functional setting, and imperative amortized analysis, which is not valid in a purely functional setting.

Balanced binary search trees with O(1) finger updates. In Making Data Structures Persistent, James R Driscoll, Neil Sarnak, Daniel D. Sleator, and Robert E. Tarjan present a method for grouping the nodes in a red-black tree so that persistent updates require only O(1) space. The purely functional deques and finger trees designed by Tarjan, Kaplan, and Mihaescu all use a very similar grouping technique to allow O(1) updates at both ends. AVL-trees for localized search by Athanasios K. Tsakalidis works similarly.

Faster pairing heaps or better bounds for pairing heaps: Since Okasaki's book was published, several new analyses of imperative pairing heaps have appeared, including Pairing heaps with O(log log n) decrease Cost by Amr Elmasry and Towards a Final Analysis of Pairing Heaps by Seth Pettie. It may be possible to apply some of this work to Okasaki's lazy pairing heaps.

Deterministic biased finger trees: In Biased Skip Lists, by Amitabha Bagchi, Adam L. Buchsbaum, and Michael T. Goodrich, a design is presented for deterministic biased skip lists. Through the skip list/tree transformation mentioned above, it may be possible to make deterministic biased search trees. The finger biased skip lists described by John Iacono and Özgür Özkan in Mergeable Dictionaries might then be possible on biased skip trees. A biased finger tree is suggested by Demaine et al. in their paper on purely functional tries (see above) as a way to reduce the time-and space bounds on finger update in tries.

The String B-Tree: A New Data Structure for String Search in External Memory and its Applications by Paolo Ferragina and Roberto Grossi is a well studied data structure combining the benefits of tries and B-trees.
