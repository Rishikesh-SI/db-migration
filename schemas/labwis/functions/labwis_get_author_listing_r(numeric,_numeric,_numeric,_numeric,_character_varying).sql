-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_author_listing_r(numeric, numeric, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: labwis_get_author_listing_r(numeric, numeric, numeric, numeric, character varying); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_author_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_min_content numeric, p_filter character varying, OUT p_authorcount numeric, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare

		v_limit smallint := case p_pagenumber when 1 then p_page1_size else p_itemnumber end;
		v_offset smallint := case p_pagenumber when 1 then 0 else (p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - p_itemnumber)) end;
		v_start character varying := split_part(p_filter,'-',1);
		v_end	character varying := split_part(p_filter,'-',2);
		v_min_content numeric := p_min_content;
		
begin
		
		
		execute 'select ''{"items":''||json_agg(tab)||''}'' 
				from (select 
						u.user_id as author_id, u.full_name as full_name , u.profile_picture_url as profile_image , u.designation , count(aa.asset_id) as content_count
		from   labwis.labwis_user u
		join   labwis.labwis_author_action aa on aa.author_id = u.user_id and asset_type_id in (1,4)
		where  aa.author_id not in (1,21)
		and u.full_name between $4 and $5
		and aa.action_id = 4
		group by aa.author_id, u.user_id,u.full_name,u.profile_picture_url
		having count(aa.asset_id) >= $3
		order by u.updated_date
		limit $1
		offset $2
		
		)tab '
		into   p_authorjson
		using v_limit,v_offset,v_min_content,v_start,v_end;
		
		execute 'select count(1)
		from   labwis.labwis_user u
		join   labwis.labwis_author_action aa on aa.author_id = u.user_id and asset_type_id in (1,4)'
		into p_authorcount;
		
end;
$_$;


--
