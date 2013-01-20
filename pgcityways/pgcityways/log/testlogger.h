#ifndef TESTLOGGER_H
#define TESTLOGGER_H

#define DEBUG 1
//#undef DEBUG
#include <string>

#ifdef DEBUG
class DebugLogger{
  std::string fName;
  public:
  DebugLogger(const char* fName);
  void setFileName(std::string fName);
  void pgDebug (const char * __restrict__ format, ...);
  void vpgDebug(const char * __restrict__ format, va_list vl);
};
extern DebugLogger* debugLogger;
#endif // DEBUG

void  pgInitLog(const char* fName);
void  pgDebug(const char *__restrict format, ...);

#endif // TESTLOGGER_H
