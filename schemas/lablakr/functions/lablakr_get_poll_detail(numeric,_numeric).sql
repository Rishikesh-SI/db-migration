-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_get_poll_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: lablakr_get_poll_detail(numeric, numeric); Type: FUNCTION; Schema: lablakr; Owner: -
--

CREATE FUNCTION lablakr.lablakr_get_poll_detail(p_pollid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_polljson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_versionnumber numeric;
     -- v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  lablakr.lablakr_poll
          where  	  poll_id = p_pollid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_polljson
     from   	  lablakr.lablakr_asset_draft
     where  	  asset_type_id  = 6
     and    	  asset_id       = p_pollid
	and    	  version_number = v_versionnumber;
     
     /*select image_path
     into   v_image_path
     from 	lablakr.lablakr_image
     where image_id = (
     select asset_id
     from   lablakr.lablakr_poll_asset_map
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
