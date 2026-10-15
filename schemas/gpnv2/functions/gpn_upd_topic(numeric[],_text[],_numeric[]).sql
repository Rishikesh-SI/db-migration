-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_upd_topic(numeric[], text[], numeric[])
-- Type: FUNCTION

-- Name: gpn_upd_topic(numeric[], text[], numeric[]); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_upd_topic(p_topic_id numeric[], p_topic_arn text[], p_application_id numeric[], OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_application_id_arr numeric[];
	v_application_id numeric;
	
begin
	
	drop table if exists t_topic_upd;
	
	create temp table t_topic_upd
	(
		c_topic_id numeric,
		c_topic_arn text,
		c_application_id numeric
	);
	
	insert into t_topic_upd(c_topic_id, c_topic_arn, c_application_id)
	select unnest(p_topic_id), unnest(p_topic_arn), unnest(p_application_id);
	
	select array(select distinct c_application_id
			   from t_topic_upd)
	into v_application_id_arr;
	
	for v_application_id in(select application_id from unnest(v_application_id_arr) u(application_id))
	loop
		
		update gpnv2.gpn_topic t
		set topic_arn = tab.c_topic_arn,
			status = 1
		from t_topic_upd tab
		where t.application_id = v_application_id
		and t.topic_id = tab.c_topic_id
		and t.topic_arn is null
		and t.status = 0;
		
	end loop;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
end;
$$;


--
