-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: create_partition(timestamp without time zone)
-- Type: FUNCTION

-- Name: create_partition(timestamp without time zone); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.create_partition(p_date timestamp without time zone) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
      partition_date TEXT;
      partition TEXT;
	  start_date text;
	  end_date text;
	  str text;
    BEGIN
      partition_date := to_char(p_date,'YYYY');
      partition := 'yho_article_test_'||partition_date;
	  start_date:=partition_date||'-'||'01'||'-'||'01';
	  end_date := (partition_date::numeric + 1)||'-'||'01'||'-'||'01';
      IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname=partition) THEN
        RAISE NOTICE 'A partition has been created %',partition;
     
	 execute 'CREATE TABLE '|| partition || ' PARTITION OF yho.yho_article_test
    FOR VALUES FROM ('''||start_date||''') TO ('''||end_date||''')';
	
	 END IF;
       RETURN NULL;
    END;
  
$$;


--
