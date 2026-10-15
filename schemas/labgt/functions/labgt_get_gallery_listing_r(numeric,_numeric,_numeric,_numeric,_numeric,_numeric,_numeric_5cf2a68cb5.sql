-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_gallery_listing_r(numeric, numeric, numeric, numeric, numeric, numeric, numeric, character varying, date, date)
-- Type: FUNCTION

-- Name: labgt_get_gallery_listing_r(numeric, numeric, numeric, numeric, numeric, numeric, numeric, character varying, date, date); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_gallery_listing_r(p_gallery_type numeric, p_season_id numeric, p_status numeric, p_page1size numeric, p_pagenumber numeric, p_itemnumber numeric, p_opt_type numeric, p_user_guid character varying, p_start_date date, p_end_date date, OUT p_gallery_json jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare

    v_fromrownumber        numeric;
    v_torownumber          numeric;
    v_gallery_type_filter  varchar(100) := ' ';
    v_season_filter        varchar(100) := ' ';
    v_status_filter        varchar(100) := ' ';
    v_user_guid_filter     varchar(100) := ' ';
    v_date_filter          varchar(200) := ' ';
    v_gallery_id_arr       numeric[];
    v_opt_type             numeric;
    v_first_name           varchar;
    v_last_name            varchar;
    v_user_guid            character varying;
    v_start_date           character varying;
    v_end_date             character varying;
    v_test                 jsonb;

begin

    v_user_guid := p_user_guid;
    v_start_date := p_start_date;
    v_end_date := p_end_date;
    p_page1size := p_itemnumber;

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'Mygallery_log'::text, 
'logs'::text,uuid_generate_v4(),jsonb_build_object('p_page1size', p_page1size,'p_pagenumber', p_pagenumber,'p_itemnumber',p_itemnumber, 'p_opt_type', p_opt_type, 
'p_user_guid',p_user_guid, 'p_start_date',p_start_date, 'p_end_date',p_end_date),current_timestamp,'labgt','logs');

    if p_page1size is null then
        v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber   := p_pagenumber * p_itemnumber;
    else
        if p_pagenumber = 1 then
            v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        else
            v_fromrownumber := p_page1size + (((p_pagenumber - 1) * p_itemnumber) - (p_itemnumber - 1));
        end if;
        v_torownumber := p_page1size + ((p_pagenumber - 1) * p_itemnumber);
    end if;

    if p_gallery_type is not null then
        v_gallery_type_filter := ' and gallery_type = $1 ';
    end if;

    if p_season_id is not null then
        v_season_filter := ' and coalesce(season_id,0) = $2 ';
    end if;

    if p_status is not null then
        v_status_filter := ' and status = $3 ';
    end if;

    if p_user_guid is not null then
        v_user_guid_filter := ' and g.user_guid = $4 ';
    end if;

    IF p_start_date IS NOT NULL AND p_end_date IS NOT NULL THEN
        
        if p_start_date::text = p_end_date::text then
            raise notice '1date : % %', p_start_date, p_start_date;
            v_date_filter := ' AND g.created_date::date = $5::date ';
        else
            raise notice '2date : % %', p_start_date, p_start_date;
            v_date_filter := ' AND g.created_date::date BETWEEN $5::date AND $6::date ';
        end if;
    ELSIF p_start_date IS NOT NULL AND p_end_date IS NULL THEN
        v_date_filter := ' AND g.created_date::date = $5::date ';
    ELSIF p_start_date IS NULL AND p_end_date IS NULL THEN
        v_date_filter := ' AND true ';
    END IF;

    v_opt_type := coalesce(p_opt_type, 1);

    execute 'select count(1)
                from labgt.labgt_gallery g
                join labgt.labgt_web_user wu using(user_guid)
                where g.is_deleted= 0 and g.is_active=1 '
                -- ||v_gallery_type_filter
                -- ||v_season_filter
                ||v_status_filter 
                || v_user_guid_filter
                || v_date_filter
        using p_gallery_type, p_season_id, p_status, v_user_guid, v_start_date::date, v_end_date::date, v_opt_type
        into p_count;

    if p_count > 0 then
        raise notice 'p_count>0:%', p_count;
        execute 'select array(SELECT gallery_id
                                FROM (
                                    SELECT g.gallery_id, ROW_NUMBER() OVER (ORDER BY g.updated_date DESC) AS rno
                                    FROM labgt.labgt_gallery g
                                    JOIN labgt.labgt_web_user wu USING (user_guid)
                                    WHERE g.is_deleted = 0 
                                      AND g.is_active = 1'
                                    --||v_season_filter
                                    ||v_status_filter
                                    || v_user_guid_filter
                                    || v_date_filter
                                    ||') tab
                                where rno between $7 and $8)'
            using p_gallery_type, p_season_id, p_status, v_user_guid, v_start_date::date, v_end_date::date, v_fromrownumber, v_torownumber, v_opt_type
            into v_gallery_id_arr;

        select ('{"data":' || json_agg(row_to_json(row))::text || '}')::jsonb
        from (
            select gallery_id, comment, is_fav_comment, gallery_name, gallery_path,
                   season_id, gallery_type, thumbnail, url, --created_date,
                   frame_id, user_guid, additional_info, json_build_object('first_name', first_name, 'last_name', last_name) as user_info, status, user_guid, created_date --,location 
            from (
                select 
                    gallery_id, comment, coalesce(is_fav_comment, 0) as is_fav_comment,
                    gallery_name, gallery_path, season_id, gallery_type, thumbnail,
                    'https://stg-gujarat-titans.sportz.io/static-assets/' 
                        || gallery_path || '/' || coalesce(user_guid, '') || 
                        '/' || is_gif_created || '/' || gallery_name as url,
                    frame_id, g.user_guid as user_guid, g.additional_info as additional_info, wu.first_name as first_name, wu.last_name as last_name, --,g.additional_info->>'photoLocation' as location
                    g.status, g.created_date as created_date
                from labgt.labgt_gallery g 
                join labgt.labgt_web_user wu using(user_guid)
                WHERE gallery_id = ANY(v_gallery_id_arr)
                  and (case when v_user_guid is not null then g.user_guid = v_user_guid else true end)
                  and (case 
                        when v_start_date is not null and v_end_date is not null then 
                            g.created_date::date between v_start_date::date and v_end_date::date
                        when v_start_date is not null and v_end_date is null then g.created_date::date = v_start_date::date
                        when v_start_date is null and v_end_date is null then true
                    end)
                order by g.updated_date desc
            ) a
        ) row
        into p_gallery_json;

        if p_gallery_json is null then
            p_gallery_json := '{"items":[]}'::jsonb;
        end if;        
    elsif p_gallery_json is null then
        p_gallery_json := '{"items":[]}'::jsonb;        
    end if;

end;
$_$;


--
