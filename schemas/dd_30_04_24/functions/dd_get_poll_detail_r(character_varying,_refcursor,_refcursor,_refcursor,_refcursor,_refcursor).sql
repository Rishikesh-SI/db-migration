-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_poll_detail_r(character varying, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dd_get_poll_detail_r(character varying, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_poll_detail_r(p_pollid character varying, p_poll_cur refcursor, p_option_cur refcursor, p_author_cur refcursor, p_poll_responce_cur refcursor, p_poll_image_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
	v_sysdate timestamp;
	v_pollid numeric;
	v_poll_entity_arr numeric[];
	v_arr_length numeric;
	v_next_pollid numeric;
	
begin
	
	v_sysdate := current_timestamp at time zone 'utc';
	
	select poll_id into v_pollid
	from dd.dd_poll
	where (alias = p_pollid or poll_id::text = p_pollid)
	and is_published = 1
	and is_trashed = 0
	and start_date <= v_sysdate;
	
	select array(select entity_role_map_id from dd.dd_asset_entity_map where asset_id = v_pollid and asset_type_id = 6) into v_poll_entity_arr;
	
	select array_length(v_poll_entity_arr, 1) into v_arr_length;
	
	if v_arr_length > 0 then
		
		select p.poll_id into v_next_pollid
		from dd.dd_poll p
		where exists(select 1 from dd.dd_asset_entity_map aem
						where aem.asset_id = p.poll_id
						and aem.asset_type_id = 6
						and aem.entity_role_map_id in(select ermid from unnest(v_poll_entity_arr) u(ermid))
						group by aem.asset_id,aem.asset_type_id
						having count(1) = v_arr_length
					)
		and p.is_published = 1
		and p.is_trashed = 0
		and p.start_date <= v_sysdate
		and p.poll_id <> v_pollid
		order by p.start_date desc
		limit 1;
		
	else
		
		select p.poll_id into v_next_pollid
		from dd.dd_poll p
		where p.is_published = 1
		and p.is_trashed = 0
		and p.start_date <= v_sysdate
		and p.poll_id <> v_pollid
		order by p.start_date desc
		limit 1;
		
	end if;
	
	open p_poll_cur for
	select *, coalesce(v_next_pollid,0) next_poll_id from dd.dd_poll where poll_id = v_pollid;
	
    open p_option_cur for
	select * from dd.dd_poll_option where poll_id = v_pollid and is_active = 1 and is_deleted = 0;
    
	open p_author_cur for
	select * from dd.dd_author_action where asset_id = v_pollid and asset_type_id = 6;
	
    open p_poll_responce_cur for
	select response_option_id as option_id, count(response_count) as response_count from dd.dd_poll_response
	where poll_id = v_pollid group by response_option_id;
	
    open p_poll_image_cur for
	select asset_id, pa.asset_type_id, image_path, image_file_name image_name, is_cover
	from dd.dd_poll_asset_map pa join dd.dd_image i on pa.asset_id = i.image_id and pa.asset_type_id = 3
	where pa.poll_id = v_pollid;
	
exception
	when others then
		null;
 	
end;

$$;


--
