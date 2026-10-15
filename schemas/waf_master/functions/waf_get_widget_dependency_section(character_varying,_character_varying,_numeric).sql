-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_widget_dependency_section(character varying, character varying, numeric)
-- Type: FUNCTION

-- Name: waf_get_widget_dependency_section(character varying, character varying, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_widget_dependency_section(p_layout_name character varying, p_comp_name character varying, p_client_id numeric, OUT p_layout_id numeric, OUT p_comp_id numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 
v_layout_name varchar(200);
v_comp_name varchar(200);
begin 

v_layout_name:=upper(p_layout_name);
v_comp_name  :=upper(p_comp_name)  ;
--

if p_comp_name is not null then 
begin 
  select component_id into strict p_comp_id  from waf_master.waf_component
   where upper(title)= v_comp_name;
   exception 
                               when no_data_found then 
                             p_comp_id := -1;
 end;
end if;

if p_layout_name is not null then 
begin 
  select A.component_layout_id into strict p_layout_id  
  from waf_master.waf_component_layout A
 join waf_master.waf_client_component_layout_map B 
 on B.component_layout_id=A.component_layout_id
  
  where upper(A.ref_number)= v_layout_name
   and A.component_id=p_comp_id
   and B.client_id=p_client_id
   limit 1;
   exception 
                               when no_data_found then 
                             p_layout_id := -1;
 end;
end if;

end

$$;


--
