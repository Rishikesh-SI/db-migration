-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_component_dependency_listing(numeric)
-- Type: FUNCTION

-- Name: waf_get_component_dependency_listing(numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_component_dependency_listing(p_comp_lay_id numeric, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_comp_id1 varchar(200) :=' ';
v_comp_type varchar(200):= ' ';
v_is_responsive varchar(200):=' ';
v_client_id  varchar(200):=' ';

v_comp_id numeric [];
begin 

 select '{"dependencies":'||array_to_json(array_agg(a))||'}' into p_result
                               	    from(
                                    
                                  select  a.component_layout_id ,
a.child_component_layout_id,b.ref_number,c.title as component_name, b.layout_name,b.layout_display_name,b.component_type_id,b.component_id,
a.meta_info,a.cldmap_guid,a.child_position,a.child_responsive
from waf_master.waf_component_layout_dependency_map a
join waf_master.waf_component_layout b on b.component_layout_id=a.child_component_layout_id
join waf_master.waf_component c on c.component_id=b.component_id and c.is_active=1
where a.component_layout_id=p_comp_lay_id
and a.is_active=1
and a.is_deleted=0
and a.is_published=1
                                        
                                      
                           			   )a ;
                                       
                                       
                                       
                 --                       exception
	-- when others then
   	-- p_result := '{"data":[{"error":"no record"}]}';
    
    if p_result is null then 
    p_result := '{"data":[{"error":"no record"}]}';
    end if ;
    
    
    
                                   
                                     exception
	 when others then
  p_result := '{"data":[{"error":"no record"}]}';

end

$$;


--
