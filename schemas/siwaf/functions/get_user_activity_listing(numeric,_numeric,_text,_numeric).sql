-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_activity_listing(numeric, numeric, text, numeric)
-- Type: FUNCTION

-- Name: _get_user_activity_listing(numeric, numeric, text, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_activity_listing(p_pagenumber numeric, p_itemnumber numeric, p_client_id text, p_user_id numeric, OUT p_asset_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
     
begin
	
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     select tot_cnt  , ('{"items":'||jsonb_agg(tab1)::text||'}')::jsonb 
	      into p_asset_count,p_json
	 from (
	 		select * from (
     						select  tracking_act_id,client_id,client_name,module_name,
	 								action_id,asset_type_id,asset_title,user_name,updated_date,current_version_number,
		 							asset_url,asset_id,user_id,asset_guid,
	 								row_number()over (order by updated_date desc) as rno,
		 							count(1) over () as tot_cnt
							from siwaf.siwaf_cms_tracking_activity
							where user_id= (case when p_user_id is null then user_id else p_user_id end)
							and  client_id=p_client_id
							) tab 
		 					where rno between v_fromrownumber and v_torownumber
         )tab1 group by tot_cnt;
		 
	-- select *  from siwaf.siwaf_cms_tracking_activity;
 exception
	
     when others then
      	p_asset_count := -1;
          p_json  := '{"items":[]}';
     
end;

 $$;


--
