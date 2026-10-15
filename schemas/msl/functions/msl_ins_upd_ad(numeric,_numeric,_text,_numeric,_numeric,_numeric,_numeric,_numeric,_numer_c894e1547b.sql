-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_ins_upd_ad(numeric, numeric, text, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, timestamp without time zone, character varying)
-- Type: FUNCTION

-- Name: msl_ins_upd_ad(numeric, numeric, text, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, timestamp without time zone, character varying); Type: FUNCTION; Schema: msl; Owner: -
--

CREATE FUNCTION msl.msl_ins_upd_ad(p_ad_id numeric, p_ad_type numeric, p_ad_code text, p_show_in_web numeric, p_show_in_mobile numeric, p_show_in_app numeric, p_published_version_number numeric, p_is_trashed numeric, p_updated_by numeric, p_is_active numeric, p_is_deleted numeric, p_is_published numeric, p_published_date timestamp without time zone, p_ad_title character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
	v_ad_id numeric;
	v_currenttimestamp timestamp;
	v_adguid varchar(256);
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	
	if exists (select ad_id
                from   msl.msl_ad
                where  ad_id = p_ad_id) then
		
		update msl.msl_ad
		set    ad_type 			   = p_ad_type,
			   ad_code 			   = p_ad_code,
			   show_in_web 		   = coalesce(p_show_in_web,show_in_web),
			   show_in_mobile 		   = coalesce(p_show_in_mobile,show_in_mobile), 
			   show_in_app 		   = coalesce(p_show_in_app,show_in_app),
			   published_version_number = coalesce(p_published_version_number,published_version_number),
			   is_trashed   		   = coalesce(p_is_trashed,is_trashed),
			   updated_date 		   = v_currenttimestamp,
			   updated_by 			   = coalesce(p_updated_by,updated_by),
			   is_active 			   = coalesce(p_is_active,is_active),
			   is_deleted 			   = coalesce(p_is_deleted,is_deleted),
			   is_published 		   = coalesce(p_is_published,is_published),
			   published_date 		   = coalesce(p_published_date,published_date),
                  ad_title			   = coalesce(p_ad_title,ad_title)
		where   ad_id 				   = p_ad_id;
		
	else
		
		v_ad_id := nextval('msl.seq_msl_ad_id');
		v_adguid:=  uuid_generate_v4();
     	
		insert into msl.msl_ad(ad_id,
							   ad_type,
							   ad_code,
							   show_in_web,
							   show_in_mobile,
							   show_in_app,
							   published_version_number,
							   is_trashed,
							   created_date,
							   updated_date,
							   created_by,
							   updated_by,
							   is_active,
							   is_deleted,
							   is_published,
							   published_date,
							   asset_guid,
                                	   ad_title)
		values (v_ad_id,
				p_ad_type,
				p_ad_code,
				coalesce(p_show_in_web,1),
				coalesce(p_show_in_mobile,1),
				coalesce(p_show_in_app,1),
				1,
				0,
				v_currenttimestamp,
				v_currenttimestamp,
				p_updated_by,
				p_updated_by,
				coalesce(p_is_active,1),
				0,
				p_is_published,
				coalesce(p_published_date,v_currenttimestamp),
				v_adguid,
                 	p_ad_title);
		
	end if;
	
	p_result := 1;

exception
	when others then
		p_result := -1;

end;

 $$;


--
