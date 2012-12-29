#include "path.h"
#include <string>
#include <sstream>
Path::Path(vector<int>  vertexes)
{
    this->vertexes = vertexes;
}
Path::Path()
{

}

vector<int>& Path::getVertexes(){
    return this->vertexes;
}


const char* Path::toString(){
    std::ostringstream stringStream;
    stringStream << "\n";
    for(int i=this->vertexes.size()-1;i >=0; i--){
        stringStream <<"vertex[" << (this->vertexes.size() - i)  <<  "] =  " << vertexes[i] << "\n";
    }
    return stringStream.str().c_str();

}
