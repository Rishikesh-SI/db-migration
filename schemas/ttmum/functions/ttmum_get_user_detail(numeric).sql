-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_get_user_detail(numeric)
-- Type: FUNCTION

-- Name: ttmum_get_user_detail(numeric); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_get_user_detail(p_userid numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

-- select * from ttmum.ttmum_user limit 1
begin
	if p_userid is not null and exists(select 1 from ttmum.ttmum_user where user_id = p_userid) then
		select '{"data":'||row_to_json(row)||'}'
          from
          (
              select u.user_id, u.user_name, u.full_name, u.display_name, u.email_id, u.profile_picture_url, user_pwd as password,
              		 (select array_to_json(array_agg(a))
                      from(select r.role_id, r.role_name
                           from   ttmum.ttmum_user_role ur
                           join   ttmum.ttmum_role r
                           on     r.role_id = ur.role_id
                           where  ur.user_id = u.user_id
                          )a
                     )user_role, bio, is_active
              from   ttmum.ttmum_user u
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
