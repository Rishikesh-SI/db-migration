-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_get_user_detail(numeric)
-- Type: FUNCTION

-- Name: labman_get_user_detail(numeric); Type: FUNCTION; Schema: labman; Owner: -
--

CREATE FUNCTION labman.labman_get_user_detail(p_userid numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

-- select * from labman.labman_user limit 1
begin
	if p_userid is not null and exists(select 1 from labman.labman_user where user_id = p_userid) then
		select '{"data":'||row_to_json(row)||'}'
          from
          (
              select u.user_id, u.user_name, u.full_name, u.display_name, u.email_id, u.profile_picture_url, user_pwd as password,
              		 (select array_to_json(array_agg(a))
                      from(select r.role_id, r.role_name
                           from   labman.labman_user_role ur
                           join   labman.labman_role r
                           on     r.role_id = ur.role_id
                           where  ur.user_id = u.user_id
                          )a
                     )user_role, bio, is_active,
              		 (select array_to_json(array_agg(b))
                      from(select 7926 lang_id, full_name, display_name, bio
                           from   labman.labman_user u1
                           where  u1.user_id = u.user_id
                           union
                           select erm.entity_role_map_id lang_id, full_name, display_name, bio
                           from   labman.labman_user_language_map ulm
                           join   labman.labman_entity_role_map erm
                           on     erm.entity_master_id = ulm.language_master_id
                           where  ulm.user_id = u.user_id
                      	  )b
                     )user_data
              from   labman.labman_user u
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
