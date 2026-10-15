-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_author_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_author_listing_r(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_author_listing_r(p_json jsonb, OUT p_authorcount numeric, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	p_pagenumber numeric;
	p_itemnumber numeric;
	p_page1_size numeric;
	p_min_content numeric;
	p_filter character varying;
	p_author_ids character varying;	
	p_exclude_author character varying;	
	v_limit numeric;
	v_offset numeric;
	v_start character varying;
	v_end	character varying;
	v_min_content numeric;
	v_author_ids  numeric[];
	v_exclude_author_ids numeric[];
	v_array_count numeric;
	v_exclude_query text = ' ';
begin

select p_json->>'pgnum',
p_json->>'inum',
p_json->>'pgsize',
p_json->>'mincontent',
p_json->>'filter',
p_json->>'authorids',
p_json->>'extauthorids'
into 
p_pagenumber,
p_itemnumber,
p_page1_size,
p_min_content,
p_filter,
p_author_ids,
p_exclude_author;

		v_limit:= case p_pagenumber when 1 then p_page1_size else p_itemnumber end;
		v_offset:= case p_pagenumber when 1 then 0 else (p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - p_itemnumber)) end;
		if (p_filter='all')THEN
		v_start:='a';
		v_end:='z';
		ELSE
		v_start:= split_part(p_filter,'-',1);
		v_end := split_part(p_filter,'-',2);
		
		end if;

		v_min_content:= p_min_content;
		v_author_ids:= string_to_array(p_author_ids, ',')::int[];
		v_exclude_author_ids:= string_to_array(p_exclude_author, ',')::numeric[];
		v_array_count:= array_length(v_author_ids,1);
		
		raise notice 'v_exclude_author_ids %',v_exclude_author_ids;
		if (p_exclude_author is not null and p_exclude_author<>'')THEN
		v_exclude_query= 'and aa.author_id not in (select unnest($1))';
		end if;
		
		raise notice 'v_limit %',v_limit;
		raise notice 'v_offset %',v_offset;
		if (p_author_ids is null or p_author_ids = '') then
			execute 'select ''{"items":''||json_agg(tab)||''}'' 
					from (select 
							u.user_id as author_id, u.full_name as full_name , u.profile_picture_url as profile_image , u.designation , count(aa.asset_id) as content_count,replace(lower(user_name),''_'',''-'')||''-''||user_id as slug
			from   labgt.labgt_user u
			join   labgt.labgt_author_action aa on aa.author_id = u.user_id and asset_type_id in (1,4)
			where  aa.author_id not in (1,21)
			and u.full_name between $5 and $6
			and aa.action_id = 4
			'||v_exclude_query||'
			group by aa.author_id, u.user_id,u.full_name,u.profile_picture_url
			having count(aa.asset_id) >= $4
			order by u.full_name
			limit $2
			offset $3

			)tab '
			into   p_authorjson
			using v_exclude_author_ids,v_limit,v_offset,v_min_content,v_start,v_end;
raise notice 'p_authorjson %',p_authorjson;
			execute 'select count(a.*) from(select count(1)
			from   labgt.labgt_user u
			join   labgt.labgt_author_action aa on aa.author_id = u.user_id and asset_type_id in (1,4)
			where  aa.author_id not in (1,21)
			and u.full_name between $2 and $3
			and aa.action_id = 4
			'||v_exclude_query||'
			group by aa.author_id, u.user_id,u.full_name,u.profile_picture_url
			having count(aa.asset_id) >= $4)a
			'
			into p_authorcount
			using v_exclude_author_ids,v_start,v_end,v_min_content;
			
	else
			execute 'select ''{"items":''||json_agg(tab)||''}'' 
					from (select 
							u.user_id as author_id, u.full_name as full_name , u.profile_picture_url as profile_image , u.designation , count(aa.asset_id) as content_count,replace(lower(user_name),''_'',''-'')||''-''||user_id as slug
			from   labgt.labgt_user u
			join   labgt.labgt_author_action aa on aa.author_id = u.user_id and asset_type_id in (1,4)
			where  aa.author_id = ANY($4)
			and aa.action_id = 4
			'||v_exclude_query||'
			group by aa.author_id, u.user_id,u.full_name,u.profile_picture_url
			order by u.full_name
			limit $2
			offset $3

			)tab '
			into   p_authorjson
			using v_exclude_author_ids,v_limit,v_offset,v_author_ids;
			
			execute 'select $1'
			into p_authorcount
			using v_array_count;
	end if;
		
end;
$_$;


--
