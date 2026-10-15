-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_ingest_series_match(jsonb)
-- Type: FUNCTION

-- Name: gpn_ingest_series_match(jsonb); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_ingest_series_match(p_json jsonb, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

v_series_id numeric;
v_series_name varchar(500);
v_match_id  jsonb;
i jsonb;
v_current_timestamp timestamp:=current_timestamp;

begin 

 

for i in (select * from jsonb_array_elements(p_json))
loop

select i->>'series_id',
       i->>'series_name',
	  i->>'match_id'
	   into v_series_id,
	   v_series_name,
	   v_match_id;
	     
		    --raise notice '%,%',v_series_id,v_series_name;
			--- raise notice '%',v_match_id;
		    
       insert into  gpnv2.gpn_series_match_map
		   (series_map_id,series_id,series_name,source_object_id,created_date,updated_date)
		   select nextval('gpnv2.seq_gpn_series_match_map_id'),v_series_id,v_series_name,
		   t1.match_id,v_current_timestamp,v_current_timestamp
		   from (select value as match_id from  jsonb_array_elements_text(v_match_id) ) as t1
		   where not exists(select 1 from gpnv2.gpn_series_match_map m
							where m.series_id=v_series_id
							and m.source_object_id=t1.match_id
						   );
						   
						  

end loop;

 p_out:=1;

end;
 $$;


--
