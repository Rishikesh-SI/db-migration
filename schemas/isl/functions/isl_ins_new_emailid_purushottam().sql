-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_new_emailid_purushottam()
-- Type: FUNCTION

-- Name: isl_ins_new_emailid_purushottam(); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_new_emailid_purushottam() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare
	v_user_full_name text;
begin
	if tg_op = 'INSERT' and new.email_id is not null then
    
    	if not exists(select 1 from isl.isl_email_activity_user_map where email_id = new.email_id) then
			with tab as
        	(
                select eam.activity_id,coalesce(batch_id,1) batch_id, count(1) cnt,
						row_number() over(partition by eam.activity_id order by eam.activity_id, coalesce(batch_id,1) desc) slno
        		from isl.isl_email_activity_user_map eaum
        		right join isl.isl_email_activity_master eam
        		on eam.activity_id = eaum.activity_id
        		group by eam.activity_id,batch_id
        		having count(1) <= 5000
        	)
			insert into isl.isl_email_activity_user_map
    		select activity_id,new.user_full_name, new.email_id, (case when cnt >= 5000 then batch_id +1 else batch_id end),	-- batch_id,
			0
			from tab 
			where srno = 1;
        	return new;
		end if;
        
    elsif tg_op = 'UPDATE' and new.email_id is not null then
    	
        if not exists(select 1 from isl.isl_email_activity_user_map where email_id = new.email_id) then
			with tab as
        	(
                select eam.activity_id,coalesce(batch_id,1) batch_id, count(1) cnt,
						row_number() over(partition by eam.activity_id order by eam.activity_id, coalesce(batch_id,1) desc) slno
        		from isl.isl_email_activity_user_map eaum
        		right join isl.isl_email_activity_master eam
        		on eam.activity_id = eaum.activity_id
        		group by eam.activity_id,batch_id
        		having count(1) <= 5000
        	)
			insert into isl.isl_email_activity_user_map
    		select activity_id,new.user_full_name, new.email_id, (case when cnt >= 5000 then  batch_id +1 else batch_id end),	-- batch_id,
			0
			from tab 
			where srno = 1;
        else
            if new.client_id = 5 then
                select user_full_name into v_user_full_name from isl.isl_web_user where email_id = new.email_id and user_full_name is not null limit 1;
                update isl.isl_email_activity_user_map
                set user_name = v_user_full_name
                where email_id = new.email_id
                and user_name is null
                and status = 0;
            end if;
        end if ;
    end if;
    return null;
end;

$$;


--
