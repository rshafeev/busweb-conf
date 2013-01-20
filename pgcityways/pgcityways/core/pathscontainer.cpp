#include "pathscontainer.h"

#include "../log/testlogger.h"

PathsContainer::PathsContainer()
{
}
PathsContainer::~PathsContainer(){
    this->paths.clear();

}

void PathsContainer::addPath(std::shared_ptr<Path> path)
{
    pgDebug("path:");
    this->paths.push_back(path);
}


