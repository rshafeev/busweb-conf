#ifndef GRAPH_H
#define GRAPH_H
#include <array>
#include <boost/config.hpp>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>

#include "pathscontainer.h"
#include "graphdata.h"
using namespace boost;

struct Vertex
{
    int id;
    float8 cost;
};

typedef adjacency_list < listS, vecS, directedS, no_property, Vertex> graph_t;
typedef graph_traits < graph_t >::vertex_descriptor vertex_descriptor;
typedef graph_traits < graph_t >::edge_descriptor edge_descriptor;
typedef std::pair<int, int> Edge;

class Graph
{
    std::shared_ptr<GraphData> data;
    std::shared_ptr<graph_t> graph;
public:
    Graph(std::shared_ptr<GraphData> data);

    std::shared_ptr<std::vector<paths_element> > getDBPathsTable(PathsContainer &paths);
    std::shared_ptr<graph_t> getGraphObj();

};

#endif // GRAPH_H
