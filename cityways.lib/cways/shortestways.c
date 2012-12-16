
#include "postgres.h"
#include "executor/spi.h"
#include "funcapi.h"
#include "catalog/pg_type.h"
#include "fmgr.h"


#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(shortest_ways);

Datum shortest_ways(PG_FUNCTION_ARGS)
{
    int value = PG_GETARG_INT64(0);

    value = value + 5   ;

    PG_RETURN_INT32(value);
}

