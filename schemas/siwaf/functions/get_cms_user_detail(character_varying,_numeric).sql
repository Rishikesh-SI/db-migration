-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_cms_user_detail(character varying, numeric)
-- Type: FUNCTION

-- Name: _get_cms_user_detail(character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_cms_user_detail(p_schema_prefix character varying, p_user_id numeric, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_user_id numeric;
	
     
begin
	v_user_id := p_user_id;
if (p_schema_prefix <>'labwis') then	
     execute 'select (''{"data":''||string_agg(row_to_json(row)::text,'','')||''}'')::jsonb
			from (select a.user_id ,a.user_name,a.full_name,a.display_name,a.email_id,a.bio,a.profile_picture_url,a.updated_by,
			a.created_by,a.created_date,a.updated_date,a.is_published,
			a.is_active ,a.user_guid,a.reset_key,a.user_pwd as password,a.partner_id,
			b.role_id,c.role_name,a.image_id,a.image_name,a.profile_picture_url as image_path
				 from '||p_schema_prefix||'.'||p_schema_prefix||'_user a
				 join '||p_schema_prefix||'.'||p_schema_prefix||'_user_role b on a.user_id=b.user_id
				 join '||p_schema_prefix||'.'||p_schema_prefix||'_role c on b.role_id = c.role_id
				 where a.user_id ='||v_user_id||' 
				) row'
     into p_user_json;
	 
else 
	execute 'select (''{"data":''||string_agg(row_to_json(row)::text,'','')||''}'')::jsonb
			from (select a.user_id ,a.user_name,a.full_name,a.display_name,a.email_id,a.bio,a.profile_picture_url,a.updated_by,
			a.created_by,a.created_date,a.updated_date,a.is_published,
			a.is_active ,a.user_guid,a.reset_key,a.user_pwd as password,a.partner_id,
			b.role_id,c.role_name,a.image_id,a.image_name,a.profile_picture_url as image_path,a.designation,a.socialdata
				 from '||p_schema_prefix||'.'||p_schema_prefix||'_user a
				 join '||p_schema_prefix||'.'||p_schema_prefix||'_user_role b on a.user_id=b.user_id
				 join '||p_schema_prefix||'.'||p_schema_prefix||'_role c on b.role_id = c.role_id 
				 where a.user_id ='||v_user_id||' 
				) row'
     into p_user_json;
	
end if;
     	
/*exception
	when others then
     	p_user_json := ('{"data":[]}')::jsonb;*/
		
	
end;

$$;


--
