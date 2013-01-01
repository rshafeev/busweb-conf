#include "path.h"
#include <string>
#include <sstream>

#include "testlogger.h"

Path::Path(std::shared_ptr<Graph> graph,vector<int>  vertexes)
{
    this->vertexes = vertexes;
    this->graph = graph;
}
Path::Path(std::shared_ptr<Graph> graph)
{
    this->graph = graph;
}

vector<int>& Path::getVertexes(){
    return this->vertexes;
}


const char* Path::toString(){
    std::ostringstream stringStream;
    stringStream << "\n";
    for(int i=this->vertexes.size()-1;i >=0; i--){
        stringStream <<"vertex[" << (this->vertexes.size() - i)  <<  "] =  " << vertexes[i] << "\n";
    }
    return stringStream.str().c_str();

}

double Path::getCost()
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

bool Path::getEdge(edge_t &edge)
{
    return this->graph->getEdge(edge);
}

bool Path::check()
{
    std::vector<int>& path_vect = this->getVertexes();
    pgDebug("Check:");
    for(int i=path_vect.size()-1; i >=2; i--){
        bool tr1 = false;
        bool tr2 = false;

        graph->isTransitionEdge(path_vect.at(i),path_vect.at(i-1),tr1);
        graph->isTransitionEdge(path_vect.at(i-1),path_vect.at(i-2),tr2);
        pgDebug(tr1);
        if(tr1 == true && tr2 == true){
            return false;
        }


    }

    return true;
}

















