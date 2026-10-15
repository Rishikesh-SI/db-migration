-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_get_user_detail(numeric)
-- Type: FUNCTION

-- Name: ppb_get_user_detail(numeric); Type: FUNCTION; Schema: ppb; Owner: -
--

CREATE FUNCTION ppb.ppb_get_user_detail(p_userid numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$   

-- select * from ppb.ppb_user limit 1
begin
	if p_userid is not null and exists(select 1 from ppb.ppb_user where user_id = p_userid) then
		select '{"data":'||row_to_json(row)||'}'
          from
          (
              select u.user_id, u.user_name, u.full_name, u.display_name, u.email_id, u.profile_picture_url, user_pwd as password,
              		 (select array_to_json(array_agg(a))
                      from(select r.role_id, r.role_name
                           from   ppb.ppb_user_role ur
                           join   ppb.ppb_role r
                           on     r.role_id = ur.role_id
                           where  ur.user_id = u.user_id
                          )a
                     )user_role, bio, is_active
              from   ppb.ppb_user u
              where  u.user_id = p_userid
          ) as row
          into p_data;
          p_result := 1;
	else
     	p_result := 0;
          p_data := '{"data":{}}';
     end if;
exception
	when others then
     	p_result := -1;
          p_data := '{"data":{}}';
end;

   $$;


--
