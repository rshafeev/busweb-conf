k Shortest Paths in O(E*log V + L*k*log k) time (L is path length)
Implemented by Jonathan Graehl (jonathan@graehl.org)
Following David Eppstein's "Finding the k Shortest Paths" March 31, 1997 draft
(http://www.ics.uci.edu/~eppstein/ 
http://www.ics.uci.edu/~eppstein/pubs/p-kpath.html)

Some notes/incoherent mumblings: 

not well documented at all (this was a solo project)

follows the paper closely; never explicitly builds the path graph (stops at D(G))

uses plain old best-first search on the path graph to recover the paths in 
best-first order - this means it is not strictly necessary to decide
beforehand how many paths are desired; however the implementation asks for k
and returns a list of k paths (lists of arcs) - although it would be possible
to instead return an iterator that could examine the paths in order of cost, in
constant time, that was not a requirement for my use, and so the simpler, less
computationally optimal interface was used

uses global variables to cut down on parameter passing.  this could be 
changed if necessary (passing around pointer to the "global" state)
  
uses homemade data structures - list, graph, binary heap (array), binary
heap (tree, copies modified nodes, as described in paper); written before STL
was really viable in the gcc environment i was using

the test program (ktest.cc) compiles with g++ 2.7.2 and takes three arguments:
start_state_number dest_state_number how_many_paths_you_want

it expects a graph as its standard input.  the first thing in a graph is the
number of states.  states are named with 0, 1, ... num_states-1
after that come any number of:
(source_state_number dest_state_number transition_cost)

the transition weights are added together to obtain the total cost of the
path.  the total path weight is known while performing the best-first search
(before expanding the paths) but I don't bother returning it, since it doesn't
take any more time to recompute than to output the paths.  maybe it would be
useful to someone if I also return the path weights?
