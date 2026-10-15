-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_leaderboard_data_r(jsonb)
-- Type: FUNCTION

-- Name: labtcs_get_leaderboard_data_r(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_leaderboard_data_r(p_json jsonb, OUT p_report_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
  v_page_number numeric;
  v_item_number numeric;
  
  v_fromrownumber numeric;
v_torownumber numeric; 
v_user_id numeric;
v_gender varchar(50);
v_age_group varchar(50);
v_city varchar(500);
v_state_name  varchar(500);
v_group_name  varchar(500);
v_distance_asc numeric;
v_search_text varchar(500);
v_from_age numeric;
v_to_age numeric;
v_city_json jsonb;
v_corporate_json jsonb;
v_state_json jsonb;
v_age_json jsonb;
v_category varchar(500);
 begin
 
 
select  p_json->>'page_number',
        p_json->>'item_number',
		p_json->>'gender',
		p_json->>'search_text',
		p_json->>'category'
		into
		v_page_number,
		v_item_number,
		v_gender,
		v_search_text,
		v_category;
		
		
/*
{
  "page_number": "1",
  "item_number": "30",
  "gender": null,
  "search_text": "5310",
  "category": null
}
*/

v_fromrownumber := (v_page_number * v_item_number - (v_item_number - 1));
v_torownumber   := (v_page_number * v_item_number);
 ---raise notice '%,%,%,%,%,%,%',v_gender,v_state_name,v_city,v_fromrownumber,v_torownumber,
 ---v_search_text,v_user_id;
  
 
 	 select (json_agg(X))
			 from (select um.firstname,um.lastname,um.bib_no,um.gender,um.race_name as race_category,rc.elapsedTimeinSec,
				   row_number()over(order by rc.elapsedTimeinSec::int asc) as sl_no
				   from labtcs.labtcs_user_master um
				   join labtcs.labtcs_user_race_challange rc
				   on um.user_id = rc.user_id
				   where um.gender = coalesce(v_gender,gender)
				   and um.race_name = coalesce(v_category,race_name)
				   --cast(um.bib_no as varchar(500))=v_search_text
				   and (um.bib_no::text = coalesce(v_search_text,um.bib_no::text))
				   --or um.firstname = coalesce(v_search_text,firstname)
				   --or um.lastname = coalesce(v_search_text,lastname))
				   --and sl_no between v_fromrownumber  and v_torownumber or sl_no=0
				   order by rc.elapsedTimeinSec::int asc
				  )as X
				   --order by rc.elapsedTimeinSec asc
				  where sl_no between v_fromrownumber  and v_torownumber or sl_no=0 
				   into p_report_json;
 
 
  
 end;
$$;


--
