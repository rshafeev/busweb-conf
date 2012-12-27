#ifndef PATH_H
#define PATH_H
#include <vector>

using namespace std;

class Path
{

 vector<int>  vertexes;
public:
    Path(vector<int>  vertexes);
    vector<int> getVertexes();
    int getVertexesCount(){
        return this->vertexes.size();
    }
};

#endif // PATH_H
