-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_job_profile_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_get_job_profile_detail(numeric, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_job_profile_detail(p_job_profile_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_json jsonb) RETURNS record
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
v_asset_type_id numeric;

begin

     if p_versionnumber is null then

          select      version_number,asset_type_id
          
          from    labbsc_dev.labbsc_dev_job_profile
          where    job_profile_id = p_job_profile_id
		  into  v_versionnumber,v_asset_type_id;

     else

          v_versionnumber := p_versionnumber;
		   select      asset_type_id
           from    labbsc_dev.labbsc_dev_job_profile
          where    job_profile_id = p_job_profile_id
		 into  v_asset_type_id;

     end if;
	 
	  
---raise notice '%,%',v_asset_type_id,v_versionnumber;
     select  asset_data
     
     from    labbsc_dev.labbsc_dev_asset_draft
     where   ---- asset_type_id  = 36
     asset_id       = p_job_profile_id
	 and asset_type_id =v_asset_type_id
and      version_number = v_versionnumber
into   v_json;

p_json:=v_json;

     p_result := 1;

	/*exception
	when others then
	p_result := -1;*/
	
	end;
$$;


--
