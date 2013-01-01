#include "pathscontainer.h"

#include "testlogger.h"

PathsContainer::PathsContainer()
{
}
PathsContainer::~PathsContainer(){
    this->paths.clear();

}

void PathsContainer::addPath(std::shared_ptr<Path> path)
{
    pgDebug("path:");
    for(int node : path->getVertexes()){
        pgDebug(node);
    }
    if(path->check() == true){
        this->paths.push_back(path);
    }


}

paths_t PathsContainer::getDBPathsTable()
{
    paths_t result;
    result.count = (this->getElementsCount() + this->getPathsCount());

    if(result.count <= 0){
        result.arr = nullptr;
        result.count = 0;
        return result;
    }

    paths_element *arr = new paths_element[result.count];
    int j = 0;
    edge_t edge;
    for(int k=0; k < this->getPathsCount(); k++){
        std::vector<int>& path_vect = this->getPath(k)->getVertexes();
        for(int i = path_vect.size() - 1; i >= 0; i--, j++)
        {
            arr[j].path_id =k;
            arr[j].vertex_id = path_vect.at(i);
            arr[j].edge_id = -1;
            if (i == 0)
            {
                continue;
            }
            edge.source = path_vect.at(i);
            edge.target = path_vect.at(i-1);
            if(this->getPath(k)->getEdge(edge)==true){
                arr[j].edge_id = edge.id;
            }

        }
    }

    result.arr = arr;
    result.count = j;
    return result;
}
