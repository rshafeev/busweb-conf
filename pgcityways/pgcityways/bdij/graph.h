#ifndef GRAPH_H
#define GRAPH_H
#include <array>
#include <boost/config.hpp>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>

#include "../core/graphdata.h"

using namespace boost;

struct Vertex
{
    int id;
    float8 cost;
    bool is_transition;
};

typedef adjacency_list < listS, vecS, directedS, no_property, Vertex> graph_t;
typedef graph_traits < graph_t >::vertex_descriptor vertex_descriptor;
typedef graph_traits < graph_t >::edge_descriptor edge_descriptor;
typedef std::pair<int, int> Edge;

/**
 * Класс- граф. Ограничения: (не может иметь парных дуг, возможны ошибки)
 * @brief The Graph class
 */
class Graph
{
    std::shared_ptr<GraphData> data;
    std::shared_ptr<graph_t> graph;
public:
    Graph(std::shared_ptr<GraphData> data);

    std::shared_ptr<graph_t> getGraphObj();

    /**
     * @brief removeEdge Врзвращает дугу между вдумя вершинами
     * @param sourceV Начальный узел
     * @param targetV Конечный узел
     * @return дуга ли nullptr. Структура заполняется не полностью, только id и cost
     */
    bool getEdge(edge_t& edge);
    std::shared_ptr<edge_t> getEdge(int &sourceV, int &targetV);
    void   removeEdge(int &sourceV, int &targetV);
    void   addEdge(edge_t & e);
    bool   isTransitionEdge(int &sourceV, int &targetV, bool& isTransition);
    int   getNumEdges();
    int   getNumVertices();
    vertex_descriptor getVertex(int vertexID);

};

#endif // GRAPH_H
