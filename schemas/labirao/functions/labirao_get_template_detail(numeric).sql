-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_get_template_detail(numeric)
-- Type: FUNCTION

-- Name: labirao_get_template_detail(numeric); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_get_template_detail(p_template_id numeric, OUT p_json json, OUT v_asset_draft json) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

 
 

declare
v_asset_type_id numeric :=10;
v_version_number numeric;
v_draftcount numeric;
begin 

select max(version_number) into v_version_number 
from labirao.labirao_asset_draft 
where asset_id=p_template_id
and asset_type_id=v_asset_type_id;

select count(1) into v_draftcount 
from labirao.labirao_asset_draft 
where asset_id=p_template_id
and asset_type_id=v_asset_type_id;

select ('{"data":'||row_to_json(row)||'}')::text into p_json
from
(
select t.template_id, t.template_name, t.template_desc, t.published_version_number version_number, t.updated_by, t.is_published status,
   	  t.template_guid as guid, t.is_master, t.layout_id, t.is_inherited, t.parent_id, t.template_html,t.is_responsive,
      t.mobile_html, use_default_bg_color,use_default_bg_image , bg_color , bg_image_id ,
      i.image_path,i.image_file_name,
     ( select array_to_json(array_agg(a))
        from(
            select page_id
            from labirao.labirao_template
            where parent_id=p_template_id
            and is_active=1
            and is_deleted=0
            and is_published=1
    )a) as pagedata,
      
   	  (select array_to_json(array_agg(a)) componentdata
           from(select *
                from   labirao.data(null::numeric, p_template_id)
               )a
          )
   from   labirao.labirao_template t
   left join labirao.labirao_image i on i.image_id=t.bg_image_id
   where  t.template_id = p_template_id
   --  and t.is_published=1
) as row;

  if v_draftcount = 1 
   then 
 v_asset_draft := p_json ; 
  else 
    select asset_data into v_asset_draft 
    from labirao.labirao_asset_draft
    where asset_type_id=v_asset_type_id
    and asset_id=p_template_id
    and version_number=v_version_number  ;

  v_asset_draft:= p_json; -- coalesce(v_asset_draft,p_json::json);
     end if ;

-- p_result:=1;
-- exception 
-- when others then 
-- p_result:= -1;

end

 
 

 $$;


--
