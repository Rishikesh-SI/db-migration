-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_ad_comp_cont_map_list_niu(numeric, numeric, numeric[], numeric, numeric)
-- Type: FUNCTION

-- Name: stn_get_ad_comp_cont_map_list_niu(numeric, numeric, numeric[], numeric, numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_ad_comp_cont_map_list_niu(p_asset_type_id numeric, p_template_component_map_id numeric, p_entityrole_mapid numeric[], p_pageno numeric, p_itemno numeric, OUT p_data jsonb, OUT p_total numeric) RETURNS record
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

if p_pageno is not null
then
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
else 
	v_fromrownumber := 0 ;
    v_torownumber := 10000;
end if;
       
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and EXISTS (select 1
          							    from   stn.stn_asset_entity_map eam
                                                 where  eam.asset_id= M.template_component_content_map_id
                                                 and    eam.asset_type_id = M.asset_type_id 
                                                 and    eam.entity_role_map_id in (SELECT entity_role_mapid
                                                 							   FROM UNNEST($2) U(entity_role_mapid))
                                                 GROUP BY eam.asset_id, eam.asset_type_id
                                                 HAVING COUNT(1)='||v_ent_count ||')';
     	
    	end if;
        
     
    v_qry_str:= ' select array_to_json(array_agg(a)) -- into p_data
     from   (select row_number() over(order by M.updated_date desc) slno, M.*
             from stn.stn_template_component_content_map M             
     		 where M.asset_type_id = $1            
             and (M.template_component_map_id = $3 or coalesce($3,0) = 0) 
         	  and M.is_published = 1
             ' || v_entityrolemapidquery || '             
            )a
      where slno between $4 and $5 ' ;
      execute  v_qry_str into p_data
     using  p_asset_type_id,p_entityrole_mapid, p_template_component_map_id, v_fromrownumber, v_torownumber  ;
   
   
   	p_data := v_json || p_data ||'}' ; 
    
   v_qry_str:= ' select count(1) 
             from stn.stn_template_component_content_map M             
     		 where M.asset_type_id = $1            
             and (M.template_component_map_id = $3 or coalesce($3,0) = 0) 
         	  and M.is_published = 1
             ' || v_entityrolemapidquery || ' ';
      execute  v_qry_str into p_total
     using  p_asset_type_id,p_entityrole_mapid, p_template_component_map_id, v_fromrownumber, v_torownumber  ;
     
end;

 

 

$_$;


--
