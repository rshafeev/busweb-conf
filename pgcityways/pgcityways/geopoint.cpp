#include "geopoint.h"
#include <string>
#include <sstream>
#include <math.h>
using namespace std;
GeoPoint::GeoPoint()
{
}

const char* GeoPoint::toString(){

    std::ostringstream stringStream;
    stringStream <<"id: " << id <<  " x: " << x << " y:  " << y;
    return stringStream.str().c_str();
}

GeoPoint::GeoPoint(const GeoPoint& copy){
    this->x = copy.x;
    this->y = copy.y;
    this->id = copy.id;
}

GeoPoint::GeoPoint(int ID, double x,double y){
    this->x = x;
    this->y = y;
    this->id = ID;
}

int GeoPoint::getID(){
    return this->id;
}

void GeoPoint::setID(int ID){
    this->id = ID;
}

double GeoPoint::getX(){
    return this->x;
}
double GeoPoint::getY(){
    return this->y;
}
void GeoPoint::setX(double x){
    this->x = x;
}

void GeoPoint::setY(double y){
    this->y = y;
}

double GeoPoint::getEuclidDistance(GeoPoint& p1,GeoPoint &p2){
    return sqrt((p1.x - p2.x)*(p1.x - p2.x) +(p1.y - p2.y)*(p1.y - p2.y) );
}

GeoPoint* GeoPoint::getPointByID(std::vector<GeoPoint> &points,int &ID){

    if(points.size()==0)
        return nullptr;
    for(GeoPoint &x : points)
    {
        if(x.getID() == ID)
            return &x;
    }
    return nullptr;
}
