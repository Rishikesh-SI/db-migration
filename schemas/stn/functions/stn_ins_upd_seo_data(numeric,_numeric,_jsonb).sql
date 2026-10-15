-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_upd_seo_data(numeric, numeric, jsonb)
-- Type: FUNCTION

-- Name: stn_ins_upd_seo_data(numeric, numeric, jsonb); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_upd_seo_data(p_assettypeid numeric, p_assetid numeric, p_metainfojson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
     
     v_currenttimestamp    timestamp;
     v_seodataid numeric;
     v_seodataguid VARCHAR(256);
     v_asset_published_version_number numeric;
     v_asset_is_published numeric;
     v_updated_by numeric:=1;
     
BEGIN
     v_currenttimestamp := current_timestamp at time zone 'utc';
     v_seodataid := nextval('stn.seq_stn_seo_data_id');
     v_seodataguid := uuid_generate_v4();
     
     select published_version_number,is_published 
     into   v_asset_published_version_number,v_asset_is_published
     from   stn.stn_asset_list al
     where  asset_id=p_assetid
     and    asset_type_id=p_assettypeid;
     
     -- IF v_asset_published_version_number is not null and v_asset_is_published is not null THEN
           IF EXISTS (select 1 from stn.stn_seo_data where asset_id=p_assetid and asset_type_id=p_assettypeid) THEN
                
                update stn.stn_seo_data
                set    meta_info 	    = p_metainfojson,
                       updated_date   = v_currenttimestamp
                       -- ,
                  --     published_version_number=v_asset_published_version_number,
                   --    is_published   = v_asset_is_published
                where  asset_type_id = p_assettypeid  and    asset_id      = p_assetid;
                p_result := 1;
           ELSE
                v_seodataid := nextval('stn.seq_stn_seo_data_id');
                v_seodataguid := uuid_generate_v4();
                
                insert into stn.stn_seo_data(seo_data_id,
                             asset_id,asset_type_id, meta_info, published_version_number, created_date,
                             updated_date, created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
                values(v_seodataid,p_assetid, p_assettypeid, p_metainfojson, 1,
                v_currenttimestamp, v_currenttimestamp, v_updated_by, v_updated_by, 1, 0, 1, v_seodataguid);
                 
                p_result := 1;
            END IF;
     /*ELSE
          p_result := -2;
     END IF;*/
	
     

 /*exception
	 when others then
      p_result := -1;*/

END;

$$;


--
