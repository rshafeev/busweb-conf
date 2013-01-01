#ifndef TESTLOGGER_H
#define TESTLOGGER_H

#include <string>

class TestLogger{
  std::string fName;
  public:
  TestLogger(const char* fName);
  void setFileName(std::string fName);
  void pgDebug(std::string text);
};


void  pgInitLog(const char* fName);
void pgDebug(const char* text);
void pgDebug(int value);
extern TestLogger * testLogger;


#endif // TESTLOGGER_H
