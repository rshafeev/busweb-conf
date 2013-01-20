#include "YenPathFinder.h"

YenPathFinder::YenPathFinder(std::shared_ptr<GraphData> data)
{
    this->data = data;
}

paths_t YenPathFinder::findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt)
{
    paths_t result;

    result.arr = nullptr;
    result.count = 0;
    return result;

}
