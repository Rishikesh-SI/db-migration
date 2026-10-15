-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_template_comp_cont_map_list_bak1(numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: u17wc_get_template_comp_cont_map_list_bak1(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_template_comp_cont_map_list_bak1(p_asset_type_id numeric, p_template_component_map_id numeric, p_pageno numeric, p_itemno numeric, OUT p_data jsonb, OUT p_total numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$   

  

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
	
    
begin
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
     
    -- open p_data for select * from u17wc.u17wc_template_component_content_map
    -- where asset_type_id=p_asset_type_id;
    
     select array_to_json(array_agg(a)) into p_data
     from   (select row_number() over(order by updated_date desc) slno, *
             from u17wc.u17wc_template_component_content_map
     		 where asset_type_id=p_asset_type_id
             and (template_component_map_id = p_template_component_map_id  or coalesce(p_template_component_map_id,0) = 0) 
         	 )a
      where slno between v_fromrownumber and v_torownumber ;
   
    select count(1) into p_total
    from u17wc.u17wc_template_component_content_map
    where asset_type_id = p_asset_type_id
    and (template_component_map_id = p_template_component_map_id  or coalesce(p_template_component_map_id,0) = 0) ;
     
end;

 

   $$;


--
