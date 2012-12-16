	
CREATE OR REPLACE FUNCTION  bus.drop_all_funcs(schema_name text)
RETURNS void AS
$BODY$
DECLARE
 query text;
BEGIN
 FOR query IN SELECT 'DROP FUNCTION ' || ns.nspname || '.' || proname 
       || '(' || oidvectortypes(proargtypes) || ');'
  FROM pg_proc INNER JOIN pg_namespace ns ON (pg_proc.pronamespace = ns.oid)
  WHERE ns.nspname = schema_name AND proname <> 'drop_all_funcs' order by proname 
 LOOP
   BEGIN
     EXECUTE query;
     RAISE NOTICE 'query: %',query;
     EXCEPTION  WHEN OTHERS THEN 
	        RAISE  NOTICE 'Warning! Can not execute: %', query;
   END;
           
 END LOOP;
  

 
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

select bus.drop_all_funcs('bus');
DROP FUNCTION bus.drop_all_funcs(text);
