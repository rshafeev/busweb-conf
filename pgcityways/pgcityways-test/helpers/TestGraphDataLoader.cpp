#include <QFile>
#include <QTextStream>
#include <limits>
#include <iostream>
#include <vector>

#include "TestGraphDataLoader.h"
#include "geopoint.h"

using namespace std;

TestGraphDataLoader::TestGraphDataLoader()
{
}
bool parseVertex(QString &line,GeoPoint &p){
    QTextStream in(&line);
    int id = -1;
    double x = std::numeric_limits<double>::min();
    double y = std::numeric_limits<double>::min();
    in >> id >> x >> y;
    if(id<0 || x == std::numeric_limits<double>::min() || y == std::numeric_limits<double>::min())
        return false;
     p.setID(id);
     p.setX(x);
     p.setY(y);
    return true;
}
bool parseEdge(QString &line,edge_t &e){
    QTextStream in(&line);
    double source = std::numeric_limits<int>::min();
    double target = std::numeric_limits<int>::min();
    double cost = -1 ;
    in  >> source >> target >> cost;
    if( source < 0 || target < 0)
        return false;
    e.source = source;
    e.target =target;
    e.cost = cost;
    return true;
}

std::shared_ptr<GraphData> TestGraphDataLoader::loadEuclidGraphData(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        std::cout << "error: " << file.errorString().toUtf8().data();
        return std::shared_ptr<GraphData>();
    }
    std::shared_ptr<GraphData> graphData =  std::shared_ptr<GraphData>(new GraphData());

    vector<GeoPoint> points;
   std::vector<edge_t>* edges = new std::vector<edge_t>;

    QTextStream in(&file);

    // Reading vertexes;
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
        GeoPoint p;
        if(parseVertex(line,p)==true){
            points.push_back(GeoPoint(p));
        }
        //std::cout << p.toString() << "\n";
    }

    // Reading edges
    int id = 0;
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
        edge_t edge;
        if(parseEdge(line,edge)==false){
            continue;
        }
        GeoPoint* p1 = GeoPoint::getPointByID(points,edge.source);
        GeoPoint* p2 = GeoPoint::getPointByID(points,edge.target);
        if(p1!= nullptr && p2!=nullptr){
            edge_t e;
            e.id = id;
            e.source = edge.source;
            e.target = edge.target;
            e.is_transition = false;
            e.cost = GeoPoint::getEuclidDistance(*p1,*p2);

            edges->push_back(e);
            id++;
          //  std::cout << "edge: " << e.source << " " << e.target << " " << e.cost << "\n";
        }
    }
    file.close();

    graphData->directed = true;
    graphData->hasReverseCost = false;
    graphData->edgesCount = edges->size();
    graphData->edges = edges->data();

    return  graphData;
}


std::shared_ptr<GraphData> TestGraphDataLoader::loadWeightGraphData(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        std::cout << "error: " << file.errorString().toUtf8().data();
        return std::shared_ptr<GraphData>();
    }
    std::vector<edge_t>* edges = new std::vector<edge_t>;
    std::shared_ptr<GraphData> graphData =  std::shared_ptr<GraphData>(new GraphData());

    QTextStream in(&file);

    // Reading edges
     int id = 0;
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
        edge_t edge;
        if(parseEdge(line,edge)==false){
            continue;
        }
        edge.id = id;
        if(max_vertex_id < edge.source)
            max_vertex_id = edge.source;
        if(max_vertex_id < edge.target)
            max_vertex_id = edge.target;
        edges->push_back(edge);
        id++;
    }

    file.close();

    graphData->directed = true;
    graphData->hasReverseCost = false;
    graphData->edgesCount = edges->size();
    graphData->edges = edges->data();

    return  graphData;
}
