-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_get_user_detail(numeric)
-- Type: FUNCTION

-- Name: labkc_v1_get_user_detail(numeric); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_get_user_detail(p_userid numeric, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

-- select * from labkc_v1.labkc_v1_user limit 1
begin
	if p_userid is not null and exists(select 1 from labkc_v1.labkc_v1_user where user_id = p_userid) then
		select '{"data":'||row_to_json(row)||'}'
          from
          (
              select u.user_id, u.user_name, u.full_name, u.display_name, u.email_id, u.profile_picture_url, user_pwd as password,
              		 (select array_to_json(array_agg(a))
                      from(select r.role_id, r.role_name
                           from   labkc_v1.labkc_v1_user_role ur
                           join   labkc_v1.labkc_v1_role r
                           on     r.role_id = ur.role_id
                           where  ur.user_id = u.user_id
                          )a
                     )user_role, bio, is_active,
              		 (select array_to_json(array_agg(b))
                      from(select 7926 lang_id, full_name, display_name, bio
                           from   labkc_v1.labkc_v1_user u1
                           where  u1.user_id = u.user_id
                           union
                           select erm.entity_role_map_id lang_id, full_name, display_name, bio
                           from   labkc_v1.labkc_v1_user_language_map ulm
                           join   labkc_v1.labkc_v1_entity_role_map erm
                           on     erm.entity_master_id = ulm.language_master_id
                           where  ulm.user_id = u.user_id
                      	  )b
                     )user_data
              from   labkc_v1.labkc_v1_user u
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
