#ifndef PATH_H
#define PATH_H
#include "graph.h"

#include <vector>
#include <memory>

using namespace std;

class Path
{
 vector<int>  vertexes;
 std::shared_ptr<Graph> graph;
public:
    Path(std::shared_ptr<Graph> graph);
    Path(std::shared_ptr<Graph> graph,vector<int>  vertexes);
    vector<int>& getVertexes();
    int getVertexesCount(){
        return this->vertexes.size();
    }
    const char* toString();
    double getCost();
    bool getEdge(edge_t& edge);
    bool check();
};

#endif // PATH_H
