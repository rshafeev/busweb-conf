#include "graph.h"
#include <vector>

Graph::Graph(std::shared_ptr<GraphData> data)
{
    this->data = data;

    const unsigned int num_nodes = ((data->directed && data->hasReverseCost ? 2 : 1) * data->edgesCount) + 100;

    this->graph = std::shared_ptr<graph_t>(new graph_t(num_nodes));

    for (int i = 0; i < data->edgesCount; i++)
    {
        this->addEdge(data->edges[i]);
    }
}

void   Graph::addEdge(edge_t & edge){
    graph_t& g = *this->graph.get();
    edge_descriptor e; bool inserted;

    tie(e, inserted) = add_edge(edge.source, edge.target, g);

    g[e].id   = edge.id;
    g[e].cost = edge.cost;

    if (!data->directed || (data->directed && data->hasReverseCost))
    {
        tie(e, inserted) = add_edge(edge.target, edge.source, g);
        g[e].id = edge.id;

        if (data->hasReverseCost)
        {
            g[e].cost = edge.reverse_cost;
        }
        else
        {
            g[e].cost = edge.cost;
        }
    }
}

int Graph::getNumEdges()
{
    return boost::num_edges(*this->graph.get());
}

void Graph::removeEdge(int &sourceV, int &targetV){
    graph_t& g = *this->graph.get();
    boost::remove_edge(sourceV,targetV,g);
}
bool Graph::getEdge(edge_t& edge){
    graph_t& g = *this->graph.get();

    graph_traits < graph_t >::vertex_descriptor v_src = edge.source;
    graph_traits < graph_t >::vertex_descriptor v_targ = edge.target;
    graph_traits < graph_t >::edge_descriptor e;
    graph_traits < graph_t >::out_edge_iterator out_i, out_end;

    for (tie(out_i, out_end) = out_edges(v_src, g);
         out_i != out_end; ++out_i)
    {
        graph_traits < graph_t >::vertex_descriptor targ;
        e = *out_i;
        //v = source(e, g);
        targ = target(e, g);
        if (targ == v_targ)
        {
            edge.id = g[*out_i].id;
            edge.cost = g[*out_i].cost;
            return true;
        }
    }

    return false;

}
double Graph::getPathCost(std::shared_ptr<Path> path){
    double cost = 0.0;
    if(path.get() == nullptr)
        return -1;
    std::vector<int>& path_vect = path->getVertexes();
    for(int i=1; i < path_vect.size(); i++){
        edge_t e ;
        e.source = path_vect.at(i);
        e.target = path_vect.at(i - 1);
        // Найдем дугу между ними
        this->getEdge(e);
        cost += e.cost;
    }
    return cost;
}

std::shared_ptr<edge_t> Graph::getEdge(int &sourceV, int &targetV){
    graph_t& g = *this->graph.get();

    graph_traits < graph_t >::vertex_descriptor v_src = sourceV;
    graph_traits < graph_t >::vertex_descriptor v_targ = targetV;
    graph_traits < graph_t >::edge_descriptor e;
    graph_traits < graph_t >::out_edge_iterator out_i, out_end;

    for (tie(out_i, out_end) = out_edges(v_src, g);
         out_i != out_end; ++out_i)
    {
        graph_traits < graph_t >::vertex_descriptor targ;
        e = *out_i;
        //v = source(e, g);
        targ = target(e, g);
        if (targ == v_targ)
        {
            std::shared_ptr<edge_t> edge =  std::shared_ptr<edge_t>(new edge_t);
            edge->id = g[*out_i].id;
            edge->cost = g[*out_i].cost;
            return edge;
        }
    }

    return std::shared_ptr<edge_t>(nullptr);
}

paths_t Graph::getDBPathsTable(PathsContainer &paths){
    paths_t result;
    result.count = (paths.getElementsCount() + paths.getPathsCount());

    if(result.count <= 0){
        result.arr = nullptr;
        result.count = 0;
        return result;
    }

    paths_element *arr = new paths_element[result.count];
    int j = 0;
    edge_t edge;
    for(int k=0; k < paths.getPathsCount(); k++){
        std::vector<int>& path_vect = paths.getPath(k)->getVertexes();
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
            if(this->getEdge(edge)==true){
                arr[j].edge_id = edge.id;
            }

        }
    }

    result.arr = arr;
    result.count = j;
    return result;
}


std::shared_ptr<graph_t> Graph::getGraphObj()
{
    return this->graph;
}
