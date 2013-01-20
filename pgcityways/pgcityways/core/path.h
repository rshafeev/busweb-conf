#ifndef PATH_H
#define PATH_H

#include <vector>
#include <string>

using namespace std;

class Path
{
protected:

 vector<int>  vertexes;
public:
    Path();
    Path(vector<int>  vertexes);
    vector<int>& getVertexes();
    int getVertexesCount(){
        return this->vertexes.size();
    }
    std::string toString();
};

#endif // PATH_H
