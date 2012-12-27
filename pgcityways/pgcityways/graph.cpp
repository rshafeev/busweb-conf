#include "graph.h"
#include <vector>

Graph::Graph(std::shared_ptr<GraphData> data)
{
    this->data = data;
}


std::shared_ptr<std::vector<paths_element> > Graph::getDBPathsTable(PathsContainer &paths){
   std::shared_ptr<std::vector<paths_element> > arr;


    return arr;
}


std::shared_ptr<graph_t> Graph::getGraphObj()
{
    return this->graph;
}
