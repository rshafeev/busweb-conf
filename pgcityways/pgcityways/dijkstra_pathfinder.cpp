#include "dijkstra_pathfinder.h"


#include <boost/graph/dijkstra_shortest_paths.hpp>

// Maximal number of nodes in the path (to avoid infinite loops)
#define MAX_NODES 100000000

DijkstraPathFinder::DijkstraPathFinder(Graph &graph)
    : IPathFinder(graph)
{
}

std::shared_ptr<Path> DijkstraPathFinder::findDijkstraShortestPath(graph_t &graph, vertex_descriptor m_source,
                                                                   vertex_descriptor m_target,
                                                                   std::vector<vertex_descriptor> &predecessors,
                                                                   std::vector<float8> &distances){

    dijkstra_shortest_paths(graph, m_source,
                            predecessor_map(&predecessors[0]).
            weight_map(get(&Vertex::cost, graph))
            .distance_map(&distances[0]));
    std::shared_ptr<Path> path = std::shared_ptr<Path>(new Path());
    int max = MAX_NODES;
    path->getVertexes().push_back(m_target);

    while (m_target != m_source)
    {
        if (m_target == predecessors[m_target])
        {
            return std::shared_ptr<Path>(nullptr);
        }
        m_target = predecessors[m_target];

        path->getVertexes().push_back(m_target);
        if (!max--)
        {
            return std::shared_ptr<Path>(nullptr);
        }
    }
    return path;

}


TPatchsResult DijkstraPathFinder::findShortestPaths(int startVertexID, int endVertexID){
    TPatchsResult result;
    graph_t &g = *this->graph.getGraphObj().get();
    vertex_descriptor _source = vertex(startVertexID, g);

    if (_source < 0 /*|| _source >= num_nodes*/)
    {
        result.err_msg = (char *) "Starting vertex not found";
        result.result_code = -1;
        return result;
    }

    vertex_descriptor _target = vertex(endVertexID, g);
    if (_target < 0 /*|| _target >= num_nodes*/)
    {
        result.err_msg = (char *) "Ending the vertex not found";
        result.result_code = -1;
        return result;
    }

    std::vector<float8> distances(num_vertices(g));

    //Ien alg
    std::vector<vertex_descriptor> predecessors(num_vertices(g));
    PathsContainer paths;
    auto shortestPath = findDijkstraShortestPath(g,_source,_target,predecessors,distances);
    if(shortestPath.get() == nullptr){
        result.err_msg = (char *) "Can not find shortest path";
        result.result_code = -1;
        return result;

    }
    paths.addPath(shortestPath);
    std::shared_ptr<Path> minPath = shortestPath;
    vector<edge_t> delete_edges;
    unsigned int K = 15;
    for(int k=0;k < K; k++){
        edge_t del_e;
        double minCost = -1;
        std::vector<int>& path_vect = minPath->getVertexes();
        for(int i=1; i < path_vect.size(); i++){
            // Начало и конец дуги
            edge_t curr_e ;
            curr_e.source = path_vect.at(i);
            curr_e.target = path_vect.at(i - 1);
            // Найдем дугу между ними
            this->graph.getEdge(curr_e);
            // Удалим дугу из графа
            this->graph.removeEdge(curr_e.source,curr_e.target);

            // Найдем маршрут
            std::vector<float8> distances(num_vertices(g));
            std::vector<vertex_descriptor> predecessors(num_vertices(g));
            std::shared_ptr<Path> currPath = findDijkstraShortestPath(g,_source,_target,predecessors,distances);

            // Узнаем его стоимость
            if(currPath.get()!=nullptr){
                double currCost = this->graph.getPathCost(currPath);
                // Если этот маршрут лучше предыдущих, запоминаем его
                if(currPath->getVertexesCount()>0 && (minCost > currCost || minCost < 0)){
                    minCost = currCost;
                    minPath = currPath;
                    del_e = curr_e;
                }
            }
            this->graph.addEdge(curr_e);
        }

        if(minPath.get()!=nullptr && minPath->getVertexesCount() > 0&& minCost>0){
            paths.addPath(minPath);
            this->graph.removeEdge(del_e.source,del_e.target);
            delete_edges.push_back(del_e);
        }else
            break;

    }

    // Восстановим граф
    for(auto &e : delete_edges){
        this->graph.addEdge(e);
    }

    //------------------------


    result.err_msg = NULL;
    result.paths = paths;
    result.result_code = EXIT_SUCCESS;
    return result;
}
