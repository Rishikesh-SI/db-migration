-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_top_user_data_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_get_top_user_data_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_top_user_data_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

declare

v_poll_id numeric ;
v_poll_desc jsonb ;

begin

   select p_json->'data'->>'poll_id'
   		  into v_poll_id;

	select  poll_desc::jsonb into v_poll_desc  from labsaw.labsaw_poll
	where poll_id = v_poll_id ;
	
    select '{"data":'||jsonb_agg(row)::text||'}'
	into p_data
	from
	(select user_guid,total_coins,row_number() over(order by total_coins desc) rank from labsaw.labsaw_user_poll_response pr
	left join labsaw.labsaw_web_user wu on wu.user_id = pr.user_id 
	where poll_id = v_poll_id and total_coins is not null 
	order by total_coins desc
	limit 3) row ;
	
	p_data := jsonb_set(p_data,'{poll_desc}',v_poll_desc,true);
	
	--raise notice '%' ,p_json;

end;

$$;


--
