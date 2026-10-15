-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_poll_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: swa_get_poll_detail(numeric, numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_poll_detail(p_pollid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_polljson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     -- v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  swa.swa_poll
          where  	  poll_id = p_pollid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_polljson
     from   	  swa.swa_asset_draft
     where  	  asset_type_id  = 6
     and    	  asset_id       = p_pollid
	and    	  version_number = v_versionnumber;
     
     /*select image_path
     into   v_image_path
     from 	swa.swa_image
     where image_id = (
     select asset_id
     from   swa.swa_poll_asset_map
     where  poll_id = p_pollid
     and is_cover = 1);*/
     
     -- p_polljson := jsonb_set(p_polljson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

$$;


--
