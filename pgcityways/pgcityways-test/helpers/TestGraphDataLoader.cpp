#include <QFile>
#include <QTextStream>
#include <limits>

#include "TestGraphDataLoader.h"
#include "geopoint.h"

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
    in  >> source >> target;
    if( source < 0 || target < 0)
        return false;
    e.source = source;
    e.target =target;
    return true;
}
std::shared_ptr<GraphData> TestGraphDataLoader::loadGraphData(QString fileName)
{
    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        std::cout << "error: " << file.errorString().toUtf8().data();
        return std::shared_ptr<GraphData>();
    }
    std::shared_ptr<GraphData> graphData =  std::shared_ptr<GraphData>(new GraphData());

    vector<GeoPoint> points;
    std::shared_ptr<std::vector<edge_t> > edges = std::shared_ptr<std::vector<edge_t> > (new std::vector<edge_t>);

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
            e.cost = GeoPoint::getEuclidDistance(*p1,*p2);
            e.reverse_cost = -1;
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
