-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: create_partition(timestamp without time zone)
-- Type: FUNCTION

-- Name: create_partition(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_partition(p_date timestamp without time zone) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
      partition_date TEXT;
      partition TEXT;
	  start_date text;
	  end_date text;
    BEGIN
      partition_date := to_char(p_date,'YYYY');
      partition := 'yho.article_upd'||partition_date;
	  start_date:=partition_date||'-'||'01'||'-'||'01';
	  end_date := partition_date||'-'||'12'||'-'||'31';
      IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname=partition) THEN
        
        EXECUTE 'CREATE TABLE '|| partition || ' ( CHECK ( published_date >= DATE '||''''||start_date||''''||' AND published_date <= DATE '||''''||end_date||''''||' )
          ) INHERITS (yho.yho_article_upd);';
     RAISE NOTICE 'A partition has been created %',partition;
	 
	 END IF;
       RETURN NULL;
    END;
  
$$;


--
