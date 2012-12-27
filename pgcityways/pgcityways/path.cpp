#include "path.h"

Path::Path(vector<int>  vertexes)

{
    this->vertexes = vertexes;
}
vector<int> Path::getVertexes(){
    return this->vertexes;
}
