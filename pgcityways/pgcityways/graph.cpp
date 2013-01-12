#include "graph.h"
#include <vector>
#include "testlogger.h"
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
    g[e].is_transition = edge.is_transition;

    if (!data->directed || (data->directed && data->hasReverseCost))
    {
        tie(e, inserted) = add_edge(edge.target, edge.source, g);
        g[e].id = edge.id;

        if (data->hasReverseCost)
        {
            //g[e].cost = edge.reverse_cost;
        }
        else
        {
            g[e].cost = edge.cost;
        }
    }
}

bool Graph::isTransitionEdge(int &sourceV, int &targetV,bool &isTransition)
{
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
        targ = target(e, g);
        if (targ == v_targ)
        {

            isTransition = g[*out_i].is_transition;
            return true;
        }
    }

    return false;
}

int Graph::getNumEdges()
{
    return boost::num_edges(*this->graph.get());
}

vertex_descriptor Graph::getVertex(int vertexID)
{
    graph_t &g = *this->graph.get();
    return vertex(vertexID, g);
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
            edge.id = g[e].id;
            edge.cost = g[e].cost;
            edge.is_transition = g[e].is_transition;
            return true;
        }
    }
    return false;

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
            edge->is_transition = g[*out_i].is_transition;
            return edge;
        }
    }

    return std::shared_ptr<edge_t>(nullptr);
}



std::shared_ptr<graph_t> Graph::getGraphObj()
{
    return this->graph;
}
