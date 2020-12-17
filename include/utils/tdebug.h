#ifndef TDEBUG_H
#define TDEBUG_H

#include <QDebug>
#include <QFile>
#include <QIODevice>
#include <QTextStream>

#include "D:\qt\touch\touchsdk\include\touch_global.h"

typedef enum {
    TLOG_ERROR = 0,
    TLOG_WARNING,
    TLOG_INFO,
    TLOG_DEBUG,
    TLOG_VERBOSE
}TLOG_LEVEL;

class TDebug
{
public:
    TOUCHSHARED_EXPORT TDebug();
    TOUCHSHARED_EXPORT ~TDebug();

    TOUCHSHARED_EXPORT static  void debug(QString message);
    TOUCHSHARED_EXPORT static void info(QString message);
    TOUCHSHARED_EXPORT static void warning(QString message);
    TOUCHSHARED_EXPORT static void error(QString message);
    TOUCHSHARED_EXPORT static void verbose(QString message);

    TOUCHSHARED_EXPORT static void setLogLevel(TLOG_LEVEL level);
    TOUCHSHARED_EXPORT static TLOG_LEVEL getLogLevel();
    static void writeLogToFile(QString log);
    TOUCHSHARED_EXPORT static void logToConsole(bool console);

private:
    static TLOG_LEVEL level;
    static QTextStream logOut;
    static QFile logFile;
    static bool logConsole;

};
#define TSHOW_LINE(format, ...) TDebug::info(QString().sprintf("[%s %d]" format, __FILE__, __LINE__, ##__VA_ARGS__))
//#define TSHOW_LINE(format, ...)

#define TVERBOSE(format, ...) TDebug::verbose(QString().sprintf(format, ##__VA_ARGS__))
#define TDEBUG(format, ...) TDebug::debug(QString().sprintf(format, ##__VA_ARGS__))
#define TINFO(format, ...) TDebug::info(QString().sprintf(format, ##__VA_ARGS__))
#define TWARNING(format, ...) TDebug::warning(QString().sprintf(format, ##__VA_ARGS__))
#define TERROR(format, ...) TDebug::error(QString().sprintf(format, ##__VA_ARGS__))

#endif // TDEBUG_H
