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
    //auto ptr = std::make_shared<Foo>();

    dijkstra_shortest_paths(graph, m_source,
                            predecessor_map(&predecessors[0]).
            weight_map(get(&Vertex::cost, graph))
            .distance_map(&distances[0]));

    vector<int> path_vect;
    int max = MAX_NODES;
    path_vect.push_back(m_target);

    while (m_target != m_source)
    {
        if (m_target == predecessors[m_target])
        {
            return std::shared_ptr<Path>(nullptr);
        }
        m_target = predecessors[m_target];

        path_vect.push_back(m_target);
        if (!max--)
        {
            return std::shared_ptr<Path>(nullptr);
        }
    }
    return std::shared_ptr<Path>(new Path(path_vect));

}


TPatchsResult DijkstraPathFinder::findShortestPaths(int startVertexID, int endVertexID){
    TPatchsResult result;
    graph_t &graph = *this->graph.getGraphObj().get();
    vertex_descriptor _source = vertex(startVertexID, graph);

    if (_source <= 0 /*|| _source >= num_nodes*/)
    {
        result.err_msg = (char *) "Starting vertex not found";
        result.result_code = -1;
        return result;
    }

    vertex_descriptor _target = vertex(endVertexID, graph);
    if (_target <= 0 /*|| _target >= num_nodes*/)
    {
        result.err_msg = (char *) "Ending vertex not found";
        result.result_code = -1;
        return result;
    }

    std::vector<float8> distances(num_vertices(graph));

    //Ien alg
    std::vector<vertex_descriptor> predecessors(num_vertices(graph));
    PathsContainer paths;
    auto shortestPath = findDijkstraShortestPath(graph,_source,_target,predecessors,distances);
    if(shortestPath.get() == nullptr){
        result.err_msg = (char *) "Can not find shortest path";
        result.result_code = -1;
        return result;

    }
    paths.addPath(shortestPath);




    /*
    unsigned int K = 1;
    for(int k=0;k < K-1; k++){
        graph_traits < graph_t >::edge_descriptor del_e;
        vector<int> min_path_vect;
        double min_cost = -1;

        for(int i=1; i < path_vect.size(); i++){
            // Начало и конец дуги
            graph_traits < graph_t >::vertex_descriptor v_src;
            graph_traits < graph_t >::vertex_descriptor v_targ;
            v_src = path_vect.at(i);
            v_targ = path_vect.at(i - 1);
            // Найдем дугу между ними
            //graph_traits < graph_t >::edge_descriptor curr_e =  boost::edge(v_src,v_targ,graph);
            // Удалим дугу из графа
           // remove_edge(curr_e,graph);

            // Найдем маршрут
            vector<int> curr_path_vect = getShortestPath(graph,_source,_target,predecessors,distances);
            //double curr_cost = getPathCost(graph,curr_path_vect);
            double curr_cost = 10;
            // Если этот маршрут лучше предыдущих, запоминаем его
            if(min_cost > curr_cost || min_cost<0){
                min_cost = curr_cost;
                min_path_vect = curr_path_vect;
                //del_e = curr_e;
            }
            //add_edge(curr_e,graph);
        }

        if(min_path_vect.size()>0){
            path_vect = min_path_vect;
            paths_vect.push_back(path_vect);
           // remove_edge(del_e,graph);
        }else
            break;

    }
    */

    //------------------------


    result.err_msg = NULL;
    result.paths = paths;
    result.result_code = EXIT_SUCCESS;
    return result;
}
