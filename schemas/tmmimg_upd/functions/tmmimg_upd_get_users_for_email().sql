-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_users_for_email()
-- Type: FUNCTION

-- Name: tmmimg_upd_get_users_for_email(); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_users_for_email(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare

		v_user_data jsonb;
		i record;
	begin

 			/*select '{"data":'||json_agg(row)||'}' into v_user_data
			from(select  f.user_id, f.email_id as email,e.race_category_name,a.bib_no,
				 		f.user_full_name as user_name
            	from tmmimg_upd.tmmimg_upd_user_transaction a
				left join tmmimg_upd.tmmimg_upd_race_category e on a.race_category_id= e.race_category_id
				left join tmmimg_upd.tmmimg_upd_web_user f on a.user_guid = f.user_guid and 
				 		  a.race_category_id=f.race_category_id
            	where a.mail_sent is null and lower(transaction_status)='success' and total_payment= 99
				 --and a.email_id='kLujX5oMeVhCbp86pRp7TY/Be3ALsZOO+fS20xeK7xClAHNV5aOLoZTobAG06GPN6zY8UBZ/JurS+b40w3U5Vg=='
				
				limit 300)row ;*/
				
				select '{ "data": '||json_agg(tab)||'}' into v_user_data
				from (select * from(select wu.user_full_name ,wu.email_id,
										  rc.race_category_name as race_category,urc.user_id ,
										case ut.race_category_id when 1 then '10K'
								  												when 2 then '21.1K' when 3 then '42.2K' end as category
									from tmmimg_upd.tmmimg_upd_user_race_challange urc
									left join tmmimg_upd.tmmimg_upd_web_user wu on urc.user_guid = wu.user_guid
									left join tmmimg_upd.tmmimg_upd_user_transaction ut on urc.user_guid = ut.user_guid
									left join tmmimg_upd.tmmimg_upd_race_category rc on ut.race_category_id = rc.race_category_id
									where urc.is_qualified =1 and  urc.email_type = 2 and urc.mail_sent = 0
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
