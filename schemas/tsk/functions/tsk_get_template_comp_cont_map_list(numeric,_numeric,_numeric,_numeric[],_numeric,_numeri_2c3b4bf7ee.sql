-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_get_template_comp_cont_map_list(numeric, numeric, numeric, numeric[], numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: tsk_get_template_comp_cont_map_list(numeric, numeric, numeric, numeric[], numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_get_template_comp_cont_map_list(p_asset_type_id numeric, p_template_id numeric, p_template_component_map_id numeric, p_entityrole_mapid numeric[], p_pageno numeric, p_itemno numeric, p_authorid numeric, p_searchkeyword character varying, OUT p_data jsonb, OUT p_total numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	v_fromrownumber numeric;
    v_torownumber numeric;
    v_json text := '{"componentmap":';
	v_ent_count numeric ;
    v_entityrolemapidquery varchar(4000) := '';
    v_qry_str text;
    v_authorquery varchar(200) := '';
    v_searchkeyword varchar(4000) := upper(p_searchkeyword);
    v_searchquery varchar(200) := '';
begin

if p_pageno is not null
then
	v_fromrownumber := (p_pageno * p_itemno - (p_itemno - 1));
     v_torownumber   := (p_pageno * p_itemno);
else 
	v_fromrownumber := 0 ;
    v_torownumber := 10000;
end if;
    -- open p_data for select * from tsk.tsk_template_component_content_map
    -- where asset_type_id=p_asset_type_id;
    
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     
     if p_authorid is not null then
      v_authorquery := 'and m.created_by =' || p_authorid || '';
     end if;
     
     if v_searchkeyword is not null then
     v_searchquery := ' and upper(m.tccmap_display_name) like ''%'||v_searchkeyword||'%'' ' ;
     end if;
     
     	if v_ent_count > 0 then
    		
          v_entityrolemapidquery := 'and exists (select 1
          							    from   tsk.tsk_asset_entity_map eam
                                                 where  eam.asset_id=  m.template_component_content_map_id
                                                 and    eam.asset_type_id = m.asset_type_id 
                                                 and    eam.entity_role_map_id in (select entity_role_mapid
                                                 							   from unnest($2) u(entity_role_mapid))
                                                 group by eam.asset_id, eam.asset_type_id
                                                 having count(1)='||v_ent_count ||')';
     	
    	end if;
      
      
     
    v_qry_str:= 'select array_to_json(array_agg(a)) -- into p_data
     from   (select row_number() over(order by m.updated_date desc) slno, m.*
             from tsk.tsk_template_component_content_map m
             inner join tsk.tsk_template_component_map tc 
      		 on (m.template_component_map_id = tc.template_component_map_id)
     		 where m.asset_type_id = $1
             and (tc.template_id = $3 or coalesce($3,0) = 0 )
             and (m.template_component_map_id = $4 or coalesce($4,0) = 0) 
         	  and m.is_published = 1 
             ' || v_entityrolemapidquery 
             ||v_authorquery
             ||v_searchquery
             || '             
            )a
      where slno between $5 and $6 ' ;
   
      execute  v_qry_str into p_data
     using  p_asset_type_id,p_entityrole_mapid, p_template_id, p_template_component_map_id, v_fromrownumber, v_torownumber,p_authorid  ;
   
   
   	p_data := v_json || p_data ||'}' ; 
    
   v_qry_str:= 'select count(1) 
             from tsk.tsk_template_component_content_map m
             inner join tsk.tsk_template_component_map tc 
      		 on (m.template_component_map_id = tc.template_component_map_id)            
     		 where m.asset_type_id = $1
             and (tc.template_id = $3 or coalesce($3,0) = 0 )
             and (m.template_component_map_id = $4 or coalesce($4,0) = 0) 
         	  and m.is_published = 1 
             ' || v_entityrolemapidquery 
             ||v_authorquery
             ||v_searchquery||'' ;
      execute  v_qry_str into p_total
     using  p_asset_type_id,p_entityrole_mapid, p_template_id, p_template_component_map_id ,p_authorid ;
     
end;

 

$_$;


--
