-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_template_comp_cont_map_list_01022019_3586(numeric, numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: jafc_get_template_comp_cont_map_list_01022019_3586(numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_template_comp_cont_map_list_01022019_3586(p_asset_type_id numeric, p_template_id numeric, p_template_component_map_id numeric, p_pageno numeric, p_itemno numeric, OUT p_data jsonb, OUT p_total numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$  

  

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_json text := '{"componentmap":';
	
    
begin

if p_pageno is not null
then
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
else 
	v_fromrownumber := 0 ;
    v_torownumber := 10000;
end if;
    -- open p_data for select * from jafc.jafc_template_component_content_map
    -- where asset_type_id=p_asset_type_id;
    
     select array_to_json(array_agg(a)) into p_data
     from   (select row_number() over(order by M.updated_date desc) slno, M.*
             from jafc.jafc_template_component_content_map M
             inner join jafc.jafc_template_component_map TC 
      		 on (M.template_component_map_id = TC.template_component_map_id)
     		 where M.asset_type_id = p_asset_type_id
             and (TC.template_id = p_template_id or coalesce(p_template_id,0) = 0 )
             and (M.template_component_map_id = p_template_component_map_id  or coalesce(p_template_component_map_id,0) = 0) 
         	 -- and M.is_published = 1
            )a
      where slno between v_fromrownumber and v_torownumber ;
   
   	p_data := v_json || p_data ||'}' ; 
    
    select count(1) into p_total
    from jafc.jafc_template_component_content_map M
    inner join jafc.jafc_template_component_map TC 
      		 on (M.template_component_map_id = TC.template_component_map_id)
    where M.asset_type_id=p_asset_type_id
    and (TC.template_id = p_template_id or coalesce(p_template_id,0) = 0 )
    and (M.template_component_map_id = p_template_component_map_id  or coalesce(p_template_component_map_id,0) = 0)
     -- and M.is_published = 1
    ;
     
end;

 

  $$;


--
