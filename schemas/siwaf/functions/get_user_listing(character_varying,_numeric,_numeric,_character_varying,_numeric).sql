-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_user_listing(character varying, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: _get_user_listing(character varying, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_user_listing(p_schema_prefix character varying, p_page_number numeric, p_item_number numeric, p_search_keywords character varying, p_status numeric, OUT p_user_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_from_row_number numeric;
v_to_row_number numeric;
v_search_filter_query text := ' ';
v_total_count numeric;

begin

   if p_page_number is not null and p_item_number is not null then
		v_from_row_number := ((p_page_number - 1) * p_item_number) + 1;
		v_to_row_number := p_page_number * p_item_number;
	end if;

	if p_search_keywords is not null then
	   v_search_filter_query = 'and upper(u.user_name) like ''%'||upper(p_search_keywords)||'%'' ';
	end if;
	
	    
        execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_user' into v_total_count;
	
     	execute 'select (''{"users":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
				from (select u.user_id, u.user_name, u.full_name, u.display_name, u.partner_id, u.email_id, u.profile_picture_url, ur.role_id,
				    r.role_name,row_number() over(order by u.updated_date desc) slno
				 	from '||p_schema_prefix||'.'||p_schema_prefix||'_user u
				 	join '||p_schema_prefix||'.'||p_schema_prefix||'_user_role ur
				 	on u.user_id = ur.user_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_role r 
					on ur.role_id = r.role_id
					where u.is_active = '||p_status||'
				 	and ur.is_active = '||p_status||'' 
				 	||v_search_filter_query||'
					and r.is_super_admin !=1) row
					where slno between '||v_from_row_number||' and '||v_to_row_number
     		into p_user_json;
            
            
    p_user_json:= jsonb_set(p_user_json,'{total_count}',v_total_count::text::jsonb,true); 

exception
	when others then
		p_user_json := ('{"users":[]}')::jsonb;
	
end;

$$;


--
