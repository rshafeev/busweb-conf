

// Include C header first for windows build issue
#include "db/shortestpaths.h"
#include "dijkstra_pathfinder.h"


int boost_dijkstra(edge_t *edges, unsigned int count, int start_vertex, int end_vertex,
                   bool directed, bool has_reverse_cost,
                   paths_element_t **paths, int *path_count, char **err_msg)
{
    std::shared_ptr<GraphData> graphData = std::shared_ptr<GraphData>(new GraphData());
    graphData->directed = directed;
    graphData->edges =edges;
    graphData->edgesCount = count;
    graphData->hasReverseCost = has_reverse_cost;
    Graph graph(graphData);
    IPathFinder *finder = new DijkstraPathFinder(graph);
    TPatchsResult result = finder->findShortestPaths(start_vertex,end_vertex);
    delete finder;
    if(result.result_code == EXIT_SUCCESS){

        paths_t paths_result = graph.getDBPathsTable(result.paths);
        *paths =  paths_result.arr;
        *path_count = paths_result.count;
    }else{
        *err_msg = result.err_msg;
    }

    return result.result_code;
}
