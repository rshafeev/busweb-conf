
#include "testlogger.h"

#ifdef DEBUG

#include <string>
#include <iostream>
#include <sstream>
#include <stdio.h>
#include <stdarg.h>

DebugLogger * debugLogger= nullptr;

DebugLogger::DebugLogger(const char* fName){
    this->fName  = fName;
}
void DebugLogger::pgDebug(const char * __restrict__ format, ...){
    va_list vl;
    va_start(vl, format);
    vpgDebug(format,vl);
    va_end(vl);

}

void DebugLogger::vpgDebug(const char * __restrict__ format, va_list vl){
    FILE* f;
    f = fopen(fName.c_str(),"a+");
    vfprintf(f,format,vl);
    fprintf(f,"\n");
    fclose(f);
}


void pgInitLog(const char* fName){
    debugLogger = new DebugLogger(fName);

}

void pgDebug(const char * __restrict__ format, ...){
    va_list vl;
    va_start(vl, format);
    if(debugLogger!=nullptr){
        debugLogger->vpgDebug(format,vl);
    }

    va_end(vl);

}




#else
void  pgInitLog(const char* fName){

}
void pgDebug(const char *__restrict __format, ...){

}


#endif // DEBUG
