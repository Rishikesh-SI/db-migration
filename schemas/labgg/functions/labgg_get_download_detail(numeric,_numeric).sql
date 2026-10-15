-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_get_download_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labgg_get_download_detail(numeric, numeric); Type: FUNCTION; Schema: labgg; Owner: -
--

CREATE FUNCTION labgg.labgg_get_download_detail(p_download_master_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     --v_authorjsonarr jsonb[];
     --v_authorjson jsonb;
     --v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
	 v_title_alias text ;
	 v_json jsonb;

begin

     if p_versionnumber is null then

          select      version_number
          into strict v_versionnumber
          from   	  labgg.labgg_download_master
          where  	  download_master_id = p_download_master_id;

     else

          v_versionnumber := p_versionnumber;

     end if;

     select 	  asset_data
     into strict v_json
     from   	  labgg.labgg_asset_draft
     where  	  asset_type_id  = 27
     and    	  asset_id       = p_download_master_id
	and    	  version_number = v_versionnumber;

	 p_json:=v_json;

     p_result := 1;

exception

  when others then
	p_result := -1;
end;

$$;


--
