#include "pathscontainer.h"

PathsContainer::PathsContainer()
{
}
PathsContainer::~PathsContainer(){
    this->paths.clear();

}

void PathsContainer::addPath(std::shared_ptr<Path> path)
{
    this->paths.push_back(path);
}
