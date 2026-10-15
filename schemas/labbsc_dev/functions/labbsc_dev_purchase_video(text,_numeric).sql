-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_purchase_video(text, numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_purchase_video(text, numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_purchase_video(p_user_guid text, p_video_id numeric, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_id numeric;
	v_partner_name text;
	v_video_exists numeric;
	v_cart_id numeric;
	v_module_name varchar(500);
	v_activity_id numeric;
	begin
	
	select user_id,partner_name,module_name
	from labbsc_dev.labbsc_dev_web_user
	where user_guid=p_user_guid
	into v_user_id,v_partner_name,v_module_name;
	
	
		if v_module_name ='Sporjo Mentor'
		then
		v_activity_id:=8;
		else
		
		select activity_id from (select activity_id,cart_id
		from labbsc_dev.labbsc_dev_cart
		where user_id =v_user_id
	and activity_id=13
	and video_id is null
	and status=2
	order by cart_id desc) rn limit 1
	into v_activity_id;
		end if;
		raise notice '%',v_activity_id;
		
		if v_activity_id in (8,13) then
		
		select max(cart_id)
	from labbsc_dev.labbsc_dev_cart
	where user_id =v_user_id
	and activity_id=v_activity_id
	and video_id is null
	and status=2
	into v_cart_id;
		
		else
	if v_partner_name is not null 
	then
	select max(cart_id)
	from labbsc_dev.labbsc_dev_cart
	where user_id =v_user_id
	and activity_id=4
	and video_id is null
	and status=2
	and upload_flag=1
	into v_cart_id;
	
	
	
	
	end if;
	
	
	end if;
	
	if v_cart_id is not null then
	update labbsc_dev.labbsc_dev_cart
	set video_id=p_video_id
	where user_id =v_user_id
	and cart_id=v_cart_id;
	
	end if;
	
	p_out:=1;
	
	
	
	
	end;
$$;


--
