-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_user_detail(character varying, character varying)
-- Type: FUNCTION

-- Name: tmmimg_upd_get_user_detail(character varying, character varying); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_user_detail(p_user_guid character varying, p_option_type character varying, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

declare

v_email_id character varying;
v_user_id numeric;
v_race_category_id numeric;

begin
-- select * from tmmimg_upd.tmmimg_upd_user_transaction
 
	select user_id,email_id,race_category_id 
	into v_user_id,v_email_id,v_race_category_id
	from tmmimg_upd.tmmimg_upd_web_user
	where user_guid= p_user_guid;
	
	if p_option_type = '1' then
	
			if not exists(select 1 from tmmimg_upd.tmmimg_upd_user_transaction
						 where user_guid=p_user_guid and race_category_id= v_race_category_id) then
					insert into tmmimg_upd.tmmimg_upd_user_transaction(user_transaction_id,user_id,email_id,user_guid,transaction_id,
														total_payment,transaction_status,transaction_date,
														race_category_id,transaction_json,transaction_guid)	 
					values(nextval('tmmimg_upd.seq_tmmimg_upd_user_transaction_id'),v_user_id,v_email_id,p_user_guid,null,
						  null,null,current_timestamp at time zone 'utc',v_race_category_id,null,uuid_generate_v4());	 

			end if;			 

			select '{"eventjini":'||row_to_json(row)||'}' into p_user_data
			from(select  a.user_id, a.email_id as email, a.email_id as client_email, mobile_no as mobile, user_full_name as first_name,
				 		social_user_name, city , is_custom_image, transaction_guid,
					 	 is_active ,d.name as country_name, s.name state,c.name as city,a.country_id,
						 a.pincode,a.address,a.race_category_id,e.race_category_name,e.fee as amount,
				 		 f.user_transaction_id,f.transaction_id,f.transaction_status,a.user_guid,
				 		d.short_name as country_code,'INR' currency,'IND' country,f.bib_no
            	from tmmimg_upd.tmmimg_upd_web_user a
				left join waf_master.waf_cities c on a.city_id=c.city_id
				left join waf_master.waf_states s on a.state_id=s.state_id
				left join waf_master.waf_countries d on a.country_id=d.country_id
				left join tmmimg_upd.tmmimg_upd_race_category e on a.race_category_id=e.race_category_id
				left join tmmimg_upd.tmmimg_upd_user_transaction f on a.user_guid = f.user_guid and a.race_category_id=f.race_category_id
            	where a.user_guid = p_user_guid)row ;
	else
				select '{"eventjini":'||row_to_json(row)||'}' into p_user_data
				from(select  a.transaction_status,a.bib_no,b.race_category_name
				 	 from  tmmimg_upd.tmmimg_upd_user_transaction a
					 left join tmmimg_upd.tmmimg_upd_race_category b on a.race_category_id=b.race_category_id
            	 	 where user_guid = p_user_guid)row ;
				
	end if;			

	      exception
		  when others then
          p_user_data := '{"data":{}}';
end;

 
$$;


--
