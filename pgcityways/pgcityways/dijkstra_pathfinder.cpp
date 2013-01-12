#include "dijkstra_pathfinder.h"

#include "testlogger.h"

#include <boost/graph/dijkstra_shortest_paths.hpp>

// Maximal number of nodes in the path (to avoid infinite loops)
#define MAX_NODES 100000000

DijkstraPathFinder::DijkstraPathFinder(std::shared_ptr<Graph> graph)
    : IPathFinder(graph)
{
}

std::shared_ptr<Path> DijkstraPathFinder::findDijkstraShortestPath(std::shared_ptr<Graph> graph, vertex_descriptor m_source,
                                                                   vertex_descriptor m_target){
    pgDebug("DijkstraPathFinder start ...");
    graph_t &g = *graph->getGraphObj().get();
    std::vector<float8> distances(num_vertices(g));
    std::vector<vertex_descriptor> predecessors(num_vertices(g));

    dijkstra_shortest_paths(g, m_source,
                            predecessor_map(&predecessors[0]).
            weight_map(get(&Vertex::cost, g))
            .distance_map(&distances[0]));
    std::shared_ptr<Path> path = std::shared_ptr<Path>(new Path(graph));
    int max = MAX_NODES;
    path->getVertexes().push_back(m_target);

    while (m_target != m_source)
    {
        if (m_target == predecessors[m_target])
        {
            pgDebug("DijkstraPathFinder finish null...");
            return std::shared_ptr<Path>(nullptr);
        }

        m_target = predecessors[m_target];

        path->getVertexes().push_back(m_target);
        if (!max--)
        {
            pgDebug("DijkstraPathFinder finish null...");
            return std::shared_ptr<Path>(nullptr);
        }
    }

    pgDebug("DijkstraPathFinder finish ...");
    return path;

}

TPatchsResult DijkstraPathFinder::findShortestPaths(int startVertexID, int endVertexID){
    TPatchsResult result;
    graph_t &g = *this->graph->getGraphObj().get();
    vertex_descriptor _source = graph->getVertex(startVertexID);

    if (_source < 0 /*|| _source >= num_nodes*/)
    {
        result.err_msg = (char *) "Starting vertex not found";
        result.result_code = -1;
        return result;
    }

    vertex_descriptor _target = graph->getVertex(endVertexID);
    if (_target < 0 /*|| _target >= num_nodes*/)
    {
        result.err_msg = (char *) "Ending the vertex not found";
        result.result_code = -1;
        return result;
    }

    //Ien alg
    PathsContainer paths;
    auto shortestPath = findDijkstraShortestPath(graph,_source,_target);
    if(shortestPath.get() == nullptr){
        result.err_msg = (char *) "Can not find shortest path";
        result.result_code = -1;
        return result;
    }
    for(int i=0;i < 25; i++){
        paths.addPath(shortestPath);
    }
    std::shared_ptr<Path> minPath = shortestPath;
    vector<edge_t> delete_edges;
    unsigned int K = 0;
    for(int k = 0; k < K; k++){
        edge_t del_e;
        double minCost = -1;
        std::shared_ptr<Path> minCurrPath = minPath;
        std::vector<int>& path_vect = minCurrPath->getVertexes();
        // pgDebug("start find best path ...");

        for(int i=1; i < path_vect.size(); i++){
            // Начало и конец дуги
            edge_t curr_e;

            curr_e.source = path_vect.at(i);
            curr_e.target = path_vect.at(i - 1);

            // Найдем дугу между ними

            if(this->graph->getEdge(curr_e) == false)
                break;


            // Удалим дугу из графа
            this->graph->removeEdge(curr_e.source,curr_e.target);

            // Найдем маршрут
            std::shared_ptr<Path> currPath = findDijkstraShortestPath(graph,_source,_target);
            // Узнаем его стоимость
            if(currPath.get()!=nullptr){

                double currCost = currPath->getCost();

                // Если этот маршрут лучше предыдущих, запоминаем его
                if(currPath->getVertexesCount()>0 && (minCost > currCost || minCost < 0)){
                    minCost = currCost;
                    minPath = currPath;
                    del_e = curr_e;
                }
            }
            this->graph->addEdge(curr_e);
        }

        //pgDebug("finish find best path ...");
        if(minPath.get()!=nullptr && minPath->getVertexesCount() > 0 && minCost>0){
            paths.addPath(minPath);
            this->graph->removeEdge(del_e.source,del_e.target);
            delete_edges.push_back(del_e);
        }
        else
        {
            //delete_edges.push_back(del_e);
            break;
        }
    }
    pgDebug("ien alg finish!!!");
    // Восстановим граф
    for(auto &e : delete_edges){
        this->graph->addEdge(e);
    }

    //------------------------


    result.err_msg = NULL;
    result.paths = paths;
    result.result_code = EXIT_SUCCESS;
    return result;
}
