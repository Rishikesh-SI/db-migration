-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_users_for_email_qualified()
-- Type: FUNCTION

-- Name: tmmimg_upd_get_users_for_email_qualified(); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_users_for_email_qualified(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare

		v_user_data jsonb;
		i record;
	begin
				
				select '{ "data": '||json_agg(tab)||'}' into v_user_data
				from (select * from(select wu.user_full_name ,wu.email_id,
										  rc.race_category_name as race_category,urc.user_id ,
										case ut.race_category_id when 1 then '10K'
								  	when 2 then '21.1K' when 3 then '42.2K' end as category
									from tmmimg_upd.tmmimg_upd_user_race_challange urc
									left join tmmimg_upd.tmmimg_upd_web_user wu on urc.user_guid = wu.user_guid
									left join tmmimg_upd.tmmimg_upd_user_transaction ut on urc.user_guid = ut.user_guid
									left join tmmimg_upd.tmmimg_upd_race_category rc on ut.race_category_id = rc.race_category_id
									where urc.is_qualified =1 and  urc.email_type = 1 and urc.mail_sent = 0
								    limit 100  )row)tab;
				
				for i in select b->>'user_id' user_id 
			from (select b from jsonb_array_elements(v_user_data->'data') b)as a 

			loop 
				  -- raise notice '%',i.user_id::numeric;
				  update tmmimg_upd.tmmimg_upd_user_race_challange
				  set mail_sent = 1
				  where user_id = i.user_id::numeric;

			end loop ;	
		
	  
	p_user_data := v_user_data;
	
	/*exception when others then 
		p_user_data:='{}';*/
	end ; 	

	$$;


--
