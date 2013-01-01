
#include "testlogger.h"

#include <string>
#include <sstream>

TestLogger * testLogger= nullptr;

TestLogger::TestLogger(const char* fName){
    this->fName  = fName;
}
void TestLogger::pgDebug(std::string text){
    FILE* f;
    f = fopen(fName.c_str(),"a+");
    text = text + "\n";
    fwrite(text.c_str(),sizeof(char),text.length(),f);
    fclose(f);
}




void pgInitLog(const char* fName){
    testLogger = new TestLogger(fName);
}

void pgDebug(const char* text){
    /*if(testLogger!=nullptr){
        testLogger->pgDebug(text);
    }*/
}
void pgDebug(int value){
   /* if(testLogger!=nullptr){
        std::string s;
        std::stringstream out;
        out << value;
        testLogger->pgDebug(out.str());
    }*/
}

void pgDebug(bool value){
    /*if(testLogger!=nullptr){
        std::string s;
        std::stringstream out;
        out << value;
        testLogger->pgDebug(out.str());
    }*/
}

