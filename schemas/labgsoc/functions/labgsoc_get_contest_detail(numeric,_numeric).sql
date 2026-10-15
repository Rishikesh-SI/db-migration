-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_get_contest_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labgsoc_get_contest_detail(numeric, numeric); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_get_contest_detail(p_contestid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_contestjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labgsoc.labgsoc_contest
          where  	  contest_id = p_contestid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;

	 --if is_active = 1 then 
     
     select 	  asset_data
     into strict p_contestjson
     from   	  labgsoc.labgsoc_asset_draft
     where  	  asset_type_id  = 39
     and    	  asset_id       = p_contestid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	labgsoc.labgsoc_image
     where image_id = (
     select asset_id
     from   labgsoc.labgsoc_contest_asset_map
     where  contest_id = p_contestid
     and is_cover = 1);
     
     -- p_contestjson := jsonb_set(p_contestjson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;

	 --end if;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 
$$;


--
