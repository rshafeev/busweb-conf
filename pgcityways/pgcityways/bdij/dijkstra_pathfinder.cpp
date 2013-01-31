#include <hash_map>
#include <boost/graph/dijkstra_shortest_paths.hpp>

#include "dijkstra_pathfinder.h"

#include "../log/testlogger.h"

// Maximal number of nodes in the path (to avoid infinite loops)
#define MAX_NODES 100000000

DijkstraPathFinder::DijkstraPathFinder(std::shared_ptr<Graph> graph)
{
    this->graph = graph;
}

std::shared_ptr<BoostPath> DijkstraPathFinder::findDijkstraShortestPath(std::shared_ptr<Graph> graph, vertex_descriptor m_source,
                                                                        vertex_descriptor m_target){
    pgDebug("DijkstraPathFinder start ...");
    graph_t &g = *graph->getGraphObj().get();
    std::vector<float8> distances(num_vertices(g));
    std::vector<vertex_descriptor> predecessors(num_vertices(g));

    dijkstra_shortest_paths(g, m_source,
                            predecessor_map(&predecessors[0]).
            weight_map(get(&Vertex::cost, g))
            .distance_map(&distances[0]));
    std::shared_ptr<BoostPath> path = std::shared_ptr<BoostPath>(new BoostPath(graph));
    int max = MAX_NODES;
    path->getVertexes().push_back(m_target);

    while (m_target != m_source)
    {
        if (m_target == predecessors[m_target])
        {
            pgDebug("DijkstraPathFinder finish null...");
            return std::shared_ptr<BoostPath>(nullptr);
        }

        m_target = predecessors[m_target];

        path->getVertexes().push_back(m_target);
        if (!max--)
        {
            pgDebug("DijkstraPathFinder finish null...");
            return std::shared_ptr<BoostPath>(nullptr);
        }
    }

    pgDebug("DijkstraPathFinder finish ...");
    return path;

}

PathsContainer DijkstraPathFinder::findShPaths(int startVertexID, int endVertexID,int maxPathsCunt){
    graph_t &g = *this->graph->getGraphObj().get();
    vertex_descriptor _source = graph->getVertex(startVertexID);
    PathsContainer paths;
    if (_source < 0 /*|| _source >= num_nodes*/)
    {
        //result.err_msg = (char *) "Starting vertex not found";
        return paths;
    }

    vertex_descriptor _target = graph->getVertex(endVertexID);
    if (_target < 0 /*|| _target >= num_nodes*/)
    {
        //result.err_msg = (char *) "Ending the vertex not found";
        return paths;
    }

    //Ien alg

    auto shortestPath = findDijkstraShortestPath(graph,_source,_target);
    if(shortestPath.get() == nullptr){
        return paths;
    }
    if(shortestPath->check()==true){
        for(int i=0;i < 1; i++){
        paths.addPath(shortestPath);
        }
    }
    std::shared_ptr<BoostPath> minPath = shortestPath;
    vector<edge_t> delete_edges;

    for(int k = 0; k < maxPathsCunt; k++){
        edge_t del_e;
        double minCost = -1;
        std::shared_ptr<BoostPath> minCurrPath = minPath;
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
            std::shared_ptr<BoostPath> currPath = findDijkstraShortestPath(graph,_source,_target);

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
            if(minPath->check()==true){
                paths.addPath(minPath);
            }
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
    return paths;
}
paths_t DijkstraPathFinder::findShortestPaths(int startVertexID, int endVertexID,int maxPathsCunt){
    PathsContainer paths = findShPaths(startVertexID,endVertexID,maxPathsCunt);
    paths_t result = getDBPathsTable(paths);
    return result;
}


paths_t DijkstraPathFinder::getDBPathsTable(PathsContainer &pathsContainer)
{
    paths_t result;
    result.count = (pathsContainer.getElementsCount() + pathsContainer.getPathsCount());

    if(result.count <= 0){
        result.arr = nullptr;
        result.count = 0;
        return result;
    }

    paths_element *arr = new paths_element[result.count];
    int j = 0;
    edge_t edge;
    for(int k=0; k < pathsContainer.getPathsCount(); k++){
        std::vector<int>& path_vect = pathsContainer.getPath(k)->getVertexes();
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
            if(((BoostPath*)pathsContainer.getPath(k).get())->getEdge(edge)==true){
                arr[j].edge_id = edge.id;
            }
        }
    }

    result.arr = arr;
    result.count = j;
    return result;
}
