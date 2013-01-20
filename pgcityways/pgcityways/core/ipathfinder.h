#ifndef IPATHFINDER_H
#define IPATHFINDER_H

#include "../db/db_types.h"
#include "pathscontainer.h"

class IPathFinder
{
public:
    IPathFinder();
    virtual paths_t findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt) = 0;
    virtual ~IPathFinder();
};

#endif // IPATHFINDER_H
