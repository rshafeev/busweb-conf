#ifndef GEOPOINT_H
#define GEOPOINT_H

#include <vector>
class GeoPoint
{
private:
    int id;
    double x;
    double y;
public:
    GeoPoint();
    GeoPoint(const GeoPoint& copy);
    GeoPoint(int ID, double x,double y);

    int getID();
    void setID(int ID);
    double getX();
    double getY();
    void setX(double x);
    void setY(double y);
    static  double getEuclidDistance(GeoPoint &p1,GeoPoint &p2);
    static GeoPoint* getPointByID(std::vector<GeoPoint> &points,int &ID);
    const char* toString();
};

#endif // GEOPOINT_H
