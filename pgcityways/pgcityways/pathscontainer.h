#ifndef PATHSCONTAINER_H
#define PATHSCONTAINER_H



#include "path.h"
#include <memory>

class PathsContainer
{
    vector<std::shared_ptr<Path> > paths;

public:
    PathsContainer();
    ~PathsContainer();

    void addPath(std::shared_ptr<Path> path);
    int getPathsCount(){
        return paths.size();
    }

    std::shared_ptr<Path> getPath(int& ind){
        if(ind >=(int) paths.size())
            return std::shared_ptr<Path>(nullptr);
        return paths[ind];
    }

    int getElementsCount(){
        int count = 0;

        for(unsigned int i=0;i < paths.size();i++){

            std::shared_ptr<Path> ptr = this->paths[i];
            if(ptr.get() != nullptr){
                count += ptr.get()->getVertexesCount();
            }
        }
        return count;
    }



};

#endif // PATHSCONTAINER_H
