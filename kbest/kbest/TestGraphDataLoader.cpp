#include <QFile>
#include <QTextStream>
#include <limits>
#include <vector>

#include "TestGraphDataLoader.h"

using namespace std;

TestGraphDataLoader::TestGraphDataLoader()
{
}

bool parseEdge(QString &line,GraphArc &e){
    QTextStream in(&line);
    double source = std::numeric_limits<int>::min();
    double target = std::numeric_limits<int>::min();
    double weight = -1 ;
    in  >> source >> target >> weight;
    if( source < 0 || target < 0)
        return false;
    e.source = source;
    e.dest =target;
    e.weight = weight;
    return true;
}

Graph TestGraphDataLoader::loadGraphData(QString fileName)
{
    Graph g;
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        std::cout << "error: " << file.errorString().toUtf8().data();
        return  g;
    }
    vector<GraphArc*> arcs;
    QTextStream in(&file);

    // Reading edges
    int max_vertex_id = 0;
    while (!in.atEnd()) {
        QString line = in.readLine().trimmed();

        if(line.size()==0)
            continue;
        if(line.indexOf("#")>=0){
         //   std::cout << "info(comment): " << line.toUtf8().data() << "\n";
            continue;
        }
        if(line.indexOf("end;")==0){
            break;
        }
        GraphArc *edge = new GraphArc;
        if(parseEdge(line,*edge)==false){
            continue;
        }
        if(max_vertex_id < edge->source)
            max_vertex_id = edge->source;
        if(max_vertex_id < edge->dest)
            max_vertex_id = edge->dest;
        arcs.push_back(edge);
    }
    file.close();

    g.nStates = max_vertex_id;
    g.states = new GraphState[max_vertex_id];
    assert(g.nStates>0);
    for(GraphArc* arc : arcs){
        GraphArc newArc;
        newArc.data = arc;
        newArc.source = arc->source;
        newArc.dest = arc->dest;
        newArc.weight = arc->weight;

        g.states[arc->source].arcs.push(newArc);
    }
    return  g;
}
