

// Include C header first for windows build issue

#include "db/shortestpaths.h"
#include "dijkstra_pathfinder.h"
#include <array>

int boost_dijkstra(edge_t *edges, unsigned int count, int start_vertex, int end_vertex,
               bool directed, bool has_reverse_cost,
               paths_element_t **paths, int *path_count, char **err_msg)
{
    std::shared_ptr<GraphData> graphData = std::shared_ptr<GraphData>(new GraphData());
    graphData.get()->directed = directed;
    graphData.get()->edges =edges;
    graphData.get()->edgesCount = count;
    graphData.get()->hasReverseCost = has_reverse_cost;
    Graph graph(graphData);
    IPathFinder *finder = new DijkstraPathFinder(graph);
    TPatchsResult result = finder->findShortestPaths(start_vertex,end_vertex);
    if(result.result_code == EXIT_SUCCESS){

        std::shared_ptr<std::vector< paths_element_t > >  ptr = graph.getDBPathsTable(result.paths);
        *paths = ptr.get()->data();
        *path_count = ptr.get()->size();

    }else{
        *err_msg = result.err_msg;
    }


    delete finder;
    return result.result_code;
}
