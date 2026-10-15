-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_content_provider_listing(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labhkind_get_content_provider_listing(numeric, numeric, numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_content_provider_listing(p_pagenumber numeric, p_itemnumber numeric, p_status numeric, OUT p_content_provider_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
 v_fromrownumber numeric;
    v_torownumber numeric;
begin
 v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
select ('{"content":['||string_agg(row_to_json(row)::text,',')||']'||' , "count":'||cnt||'}')::jsonb
		       from   (select content_provider_id,content_provider_name,
					          content_provider_display_name,is_active,is_deleted,
					   row_number()over(order by content_provider_id desc ) as sl_no,
					   count(1) over() as cnt
					   from labhkind.labhkind_content_provider
					  where is_active=coalesce(p_status,is_active)
					  )row
					  where sl_no between v_fromrownumber and v_torownumber
					  group by cnt
		       into p_content_provider_json;	
 
end;
$$;


--
