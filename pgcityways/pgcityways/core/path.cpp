#include "path.h"
#include <string>
#include  <iostream>
#include <sstream>

#include "../log/testlogger.h"

Path::Path()
{
}

Path::Path(vector<int>  vertexes)
{
    this->vertexes = vertexes;
}
vector<int>& Path::getVertexes(){
    return this->vertexes;
}


std::string Path::toString(){
    std::ostringstream stringStream;
    stringStream << "\n";
    int count = this->vertexes.size();
    for(int i = count -1;i >=0; i--){
        int v = vertexes.at(i);
        int ind = count - i;
        stringStream <<"vertex[" << ind  <<  "] =  " << v << "\n";
    }
    return stringStream.str();

}


















