-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_get_download_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labkc_v1_get_download_detail(numeric, numeric); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_get_download_detail(p_download_master_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_json jsonb) RETURNS record
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
          from   	  labkc_v1.labkc_v1_download_master
          where  	  download_master_id = p_download_master_id;

     else

          v_versionnumber := p_versionnumber;

     end if;

     select 	  asset_data
     into strict v_json
     from   	  labkc_v1.labkc_v1_asset_draft
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
