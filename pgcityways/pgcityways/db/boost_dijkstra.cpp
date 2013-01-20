

// Include C header first for windows build issue
#include "db/shortestpaths.h"
#include "bdij/dijkstra_pathfinder.h"
#include "log/testlogger.h"

int boost_dijkstra(edge_t *edges, unsigned int count, int start_vertex, int end_vertex,
                   bool directed, bool has_reverse_cost,
                   paths_element_t **paths, int *path_count, char **err_msg)
{

    pgInitLog("/var/log/postgresql/pgcityways.log");
    pgDebug("test info!!!");


    std::shared_ptr<GraphData> graphData = std::shared_ptr<GraphData>(new GraphData());
    graphData->directed = directed;
    graphData->edges =edges;
    graphData->edgesCount = count;
    graphData->hasReverseCost = has_reverse_cost;
    std::shared_ptr<Graph> graph = std::shared_ptr<Graph>(new Graph(graphData));
    IPathFinder *finder = new DijkstraPathFinder(graph);
    paths_t paths_result = finder->findShortestPaths(start_vertex,end_vertex,3);
    delete finder;
    *paths =  paths_result.arr;
    *path_count = paths_result.count;

    return 0;
}
