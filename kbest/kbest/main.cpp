#include <iostream>
#include <strstream>
#include "TestGraphDataLoader.h"
#include "graph.h"
using namespace std;

/* k Shortest Paths in O(E*log V + L*k*log k) time (L is path length)
   Implemented by Jon Graehl (jongraehl@earthling.net)
   Following David Eppstein's "Finding the k Shortest Paths" March 31, 1997 draft
   (http://www.ics.uci.edu/~eppstein/
    http://www.ics.uci.edu/~eppstein/pubs/p-kpath.ps)
   */



int main(int argc, char *argv[])
{
  int k = 6;
  int source = 1, dest = 5;

  TestGraphDataLoader graphLoader;

  Graph graph =  graphLoader.loadGraphData("/home/romario/LinuxFiles/kbest/test-data/graph1.dat");

  List<List<GraphArc *> > *paths = bestPaths(graph, source, dest, k);
  for ( ListIter<List<GraphArc *> > pathIter(*paths) ; pathIter ; ++pathIter ) {
    float pathWeight = 0;
    GraphArc *a;
    for ( ListIter<GraphArc *> arcIter(pathIter.data()) ; arcIter ; ++arcIter ) {
      a = arcIter.data();
      pathWeight += a->weight;
      cout << *a << ' ';
    }
    cout << pathWeight << '\n';
  }
  //  cout << graph;
  return 0;
}
