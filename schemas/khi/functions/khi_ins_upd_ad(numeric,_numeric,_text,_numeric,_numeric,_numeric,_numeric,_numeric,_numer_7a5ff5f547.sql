-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_ins_upd_ad(numeric, numeric, text, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, timestamp without time zone)
-- Type: FUNCTION

-- Name: khi_ins_upd_ad(numeric, numeric, text, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, timestamp without time zone); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_ins_upd_ad(p_ad_id numeric, p_ad_type numeric, p_ad_code text, p_show_in_web numeric, p_show_in_mobile numeric, p_show_in_app numeric, p_published_version_number numeric, p_is_trashed numeric, p_updated_by numeric, p_is_active numeric, p_is_deleted numeric, p_is_published numeric, p_published_date timestamp without time zone, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
     v_ad_id numeric;
     v_currenttimestamp    timestamp;
     v_adguid varchar(256);
BEGIN
     v_currenttimestamp := current_timestamp at time zone 'utc';
     
     IF EXISTS (SELECT AD_ID FROM  khi.khi_ad WHERE ad_id=p_ad_id ) THEN
     	update khi.khi_ad   
          SET  ad_type=p_ad_type, 
          ad_code=p_ad_code, 
          show_in_web=COALESCE(P_show_in_web,show_in_web),
          show_in_mobile=COALESCE(P_show_in_mobile,show_in_mobile), 
          show_in_app=COALESCE(P_show_in_app,show_in_app),
          published_version_number=COALESCE(P_published_version_number,published_version_number),
          is_trashed=COALESCE(P_is_trashed,is_trashed), 
          updated_date=v_currenttimestamp, 
          updated_by=COALESCE(P_updated_by,updated_by),
          is_active=COALESCE(P_is_active,is_active), 
          is_deleted=COALESCE(P_is_deleted,is_deleted), 
          is_published=COALESCE(P_is_published,is_published),
          published_date=COALESCE(P_published_date,published_date) 
          where AD_ID=p_ad_id;
  	ELSE
     	v_ad_id := nextval('khi.seq_khi_ad_id');
      v_adguid:=  uuid_generate_v4();
     	INSERT INTO khi.khi_ad(
      ad_id, ad_type, ad_code, show_in_web, show_in_mobile, show_in_app, published_version_number, 
      is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
      published_date, asset_guid)
	VALUES (v_ad_id, p_ad_type, p_ad_code, COALESCE(P_show_in_web,1), COALESCE(P_show_in_mobile,1), 
          COALESCE(P_show_in_app,1), 1, 0, v_currenttimestamp, v_currenttimestamp, P_updated_by, P_updated_by, 
          COALESCE(P_is_active,1), 0, P_is_published, COALESCE(P_published_date,v_currenttimestamp) , v_adguid);
   
	END IF;
	
     p_result := 1;

 exception
	 when others then
      p_result := -1;

END;

$$;


--
