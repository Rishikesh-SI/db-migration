-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_template_comp_cont_map_list_r(numeric, numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: labkc_v1_get_template_comp_cont_map_list_r(numeric, numeric, numeric, numeric[]); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_template_comp_cont_map_list_r(p_asset_type_id numeric, p_template_id numeric, p_template_component_map_id numeric, p_entityrole_mapid numeric[], OUT p_data jsonb, OUT p_total numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_json text := '{"componentmap":';
	v_ent_count numeric ;
    v_entityrolemapidquery varchar(4000) := ' ';
    v_qry_str text;
begin
/*
if p_pageno is not null
then
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
else 
	v_fromrownumber := 0 ;
    v_torownumber := 10000;
end if;*/
    -- open p_data for select * from labkc_v1.labkc_v1_template_component_content_map
    -- where asset_type_id=p_asset_type_id;
    
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and exists (select 1
          							    from   labkc_v1.labkc_v1_asset_entity_map eam
                                                 where  eam.asset_id=  m.template_component_content_map_id
                                                 and    eam.asset_type_id = m.asset_type_id 
                                                 and    eam.entity_role_map_id in (select entity_role_mapid
                                                 							   from unnest($2) u(entity_role_mapid))
                                                 group by eam.asset_id, eam.asset_type_id
                                                 having count(1)='||v_ent_count ||')';
     	
    	end if;
        
     
    v_qry_str:= 'select array_to_json(array_agg(a)) -- into p_data
     from   (select row_number() over(order by m.updated_date desc) slno, m.*
             from labkc_v1.labkc_v1_template_component_content_map m
             inner join labkc_v1.labkc_v1_template_component_map tc 
      		 on (m.template_component_map_id = tc.template_component_map_id)
     		 where m.asset_type_id = $1
             and (tc.template_id = $3 or coalesce($3,0) = 0 )
             and (m.template_component_map_id = $4 or coalesce($4,0) = 0) 
         	  and m.is_published = 1
             ' || v_entityrolemapidquery || '             
            )a
      ' ;
      execute  v_qry_str into p_data
     using  p_asset_type_id,p_entityrole_mapid, p_template_id, p_template_component_map_id;
   
   
   	p_data := v_json || p_data ||'}' ; 
    
   v_qry_str:= 'select count(1) 
             from labkc_v1.labkc_v1_template_component_content_map m
             inner join labkc_v1.labkc_v1_template_component_map tc 
      		 on (m.template_component_map_id = tc.template_component_map_id)
     		 where m.asset_type_id = $1
             and (tc.template_id = $3 or coalesce($3,0) = 0 )
             and (m.template_component_map_id = $4 or coalesce($4,0) = 0) 
         	  and m.is_published = 1
             ' || v_entityrolemapidquery || ' ';
      execute  v_qry_str into p_total
     using  p_asset_type_id,p_entityrole_mapid, p_template_id, p_template_component_map_id  ;
     
end;

 

$_$;


--
