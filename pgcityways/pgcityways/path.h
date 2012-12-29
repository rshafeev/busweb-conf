#ifndef PATH_H
#define PATH_H
#include <vector>

using namespace std;

class Path
{
 vector<int>  vertexes;
public:
 Path();
    Path(vector<int>  vertexes);
    vector<int>& getVertexes();
    int getVertexesCount(){
        return this->vertexes.size();
    }
    const char* toString();
};

#endif // PATH_H
