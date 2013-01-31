#include "boostpath.h"
#include  "../log/testlogger.h"
BoostPath::BoostPath(std::shared_ptr<Graph> graph)
{
  this->graph = graph;
}

BoostPath::BoostPath(std::shared_ptr<Graph> graph, vector<int>  vertexes)
    :Path(vertexes)
{
  this->graph = graph;
}

double BoostPath::getCost()
{
    double cost = 0.0;

    std::vector<int>& path_vect = this->getVertexes();
    for(int i=1; i < path_vect.size(); i++){
        edge_t e ;
        e.source = path_vect.at(i);
        e.target = path_vect.at(i - 1);
        // Найдем дугу между ними
        this->graph->getEdge(e);
        cost += e.cost;
    }
    return cost;
}

bool BoostPath::getEdge(edge_t &edge)
{
    return this->graph->getEdge(edge);
}

bool BoostPath::check()
{
    return true;
    std::vector<int>& path_vect = this->getVertexes();
    pgDebug("Check:");
    for(int i=path_vect.size()-1; i >=2; i--){
        bool tr1 = false;
        bool tr2 = false;

        graph->isTransitionEdge(path_vect.at(i),path_vect.at(i-1),tr1);
        graph->isTransitionEdge(path_vect.at(i-1),path_vect.at(i-2),tr2);
        pgDebug("Check edge: %i",&tr1);
        if(tr1 == true && tr2 == true){
            return false;
        }


    }

    return true;
}

