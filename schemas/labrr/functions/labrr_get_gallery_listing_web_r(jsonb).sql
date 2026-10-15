-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_gallery_listing_web_r(jsonb)
-- Type: FUNCTION

-- Name: labrr_get_gallery_listing_web_r(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_gallery_listing_web_r(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    /*
    input json:
    {
        "pgnum":"1",
        "inum":"10",
        "asset_id":"",
        "asset_type_id":"",
        "hashtag":""
    }
	
	select * from  labrr.labrr_get_gallery_listing_web_r(
	'{
        "pgnum":"1",
        "inum":"10",
        "asset_id":"3597",
        "asset_type_id":"1",
        "hashtag":"#AavaDe"
    }');
	
    */

    v_pagenumber       numeric;
    v_itemnumber       numeric;
    v_fromrownumber    numeric;
    v_torownumber      numeric;
    v_asset_id         varchar;
    v_asset_type_id    varchar;
    v_hashtag          varchar;
	v_sort_by          varchar;

BEGIN

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labrr_get_gallery_listing_web_r','logs',uuid_generate_v4(),p_input,current_timestamp,'labrr','logs');

    SELECT
        p_input->>'pgnum',
        p_input->>'inum',
        NULLIF(p_input->>'asset_id', ''),
        NULLIF(p_input->>'asset_type_id', ''),
        NULLIF(TRIM(p_input->>'hashtag'), ''),
		NULLIF(TRIM(LOWER(p_input->>'sort_by')), '')
    INTO
        v_pagenumber,
        v_itemnumber,
        v_asset_id,
        v_asset_type_id,
        v_hashtag,
		v_sort_by;
		
	if lower(v_hashtag)= 'all' then v_hashtag:= null; end if;
	
	IF v_sort_by IS NULL OR v_sort_by NOT IN ('oldest','latest') THEN
        v_sort_by := 'latest';
    END IF;

    v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
    v_torownumber   := (v_pagenumber * v_itemnumber);

    RAISE NOTICE 'Input JSON          : %', p_input;
    RAISE NOTICE 'Page Number         : %', v_pagenumber;
    RAISE NOTICE 'Item Number         : %', v_itemnumber;
    RAISE NOTICE 'From Row            : %', v_fromrownumber;
    RAISE NOTICE 'To Row              : %', v_torownumber;
    RAISE NOTICE 'Asset ID            : %', v_asset_id;
    RAISE NOTICE 'Asset Type ID       : %', v_asset_type_id;
    RAISE NOTICE 'Hashtag Filter      : %', v_hashtag;

    IF v_asset_id IS NOT NULL THEN

        SELECT ('{"data":' || COALESCE(json_agg(row_to_json(row))::text, '[]') || '}')::jsonb
        INTO p_data
        FROM
        (
            (
                SELECT
                    additional_info,
                    gallery_type,
                    'https://stg-rr.sportz.io/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || gallery_name AS url,
                    gallery_id,
                    0 AS rn,
                    wu.first_name,
                    wu.last_name,
                    g.created_date AS date,
                    profile_picture_url AS profile,
                    'https://stg-rr.sportz.io/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || COALESCE(thumbnail, gallery_name) AS thumbnail
                FROM labrr.labrr_gallery g
                JOIN labrr.labrr_web_user wu USING (user_guid)
                WHERE g.status = 1
                  AND g.gallery_id = v_asset_id::numeric
                  AND (
                        v_hashtag IS NULL
                        OR COALESCE(g.additional_info->>'hashtag', '') ILIKE '%' || v_hashtag || '%'
                      )
            )

            UNION ALL

            (
                SELECT
                    additional_info,
                    gallery_type,
                    url,
                    gallery_id,
                    rn,
                    first_name,
                    last_name,
                    date,
                    profile,
                    thumbnail
                FROM
                (
                    SELECT
                        additional_info,
                        gallery_type,
                        'https://stg-rr.sportz.io/static-assets/'
                            || gallery_path || '/'
                            || COALESCE(user_guid, '') || '/'
                            || is_gif_created || '/'
                            || gallery_name AS url,
                        gallery_id,
						ROW_NUMBER() OVER (
                            ORDER BY is_fav_comment DESC,
                                     CASE WHEN v_sort_by = 'oldest' THEN g.updated_date END ASC NULLS LAST,
                                     g.updated_date DESC
                        ) AS rn,
                        wu.first_name,
                        wu.last_name,
                        g.created_date AS date,
                        profile_picture_url AS profile,
                        'https://stg-rr.sportz.io/static-assets/'
                            || gallery_path || '/'
                            || COALESCE(user_guid, '') || '/'
                            || is_gif_created || '/'
                            || COALESCE(thumbnail, gallery_name) AS thumbnail
                    FROM labrr.labrr_gallery g
                    JOIN labrr.labrr_web_user wu USING (user_guid)
                    WHERE g.status = 1
                      AND g.gallery_id <> v_asset_id::numeric
                      AND (
                            v_hashtag IS NULL
                            OR COALESCE(g.additional_info->>'hashtag', '') ILIKE '%' || v_hashtag || '%'
                          )
                ) b
                WHERE rn BETWEEN v_fromrownumber AND v_torownumber
            )
        ) row;

        RAISE NOTICE 'Output with asset_id : %', p_data;

    ELSE

        SELECT ('{"data":' || COALESCE(json_agg(row_to_json(row))::text, '[]') || '}')::jsonb
        INTO p_data
        FROM
        (
            SELECT
                additional_info,
                gallery_type,
                url,
                gallery_id,
                rn,
                first_name,
                last_name,
                date,
                profile,
                thumbnail
            FROM
            (
                SELECT
                    additional_info,
                    gallery_type,
                    'https://stg-rr.sportz.io/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || gallery_name AS url,
                    gallery_id,
					ROW_NUMBER() OVER (
                        ORDER BY is_fav_comment DESC,
                                 CASE WHEN v_sort_by = 'oldest' THEN g.updated_date END ASC NULLS LAST,
                                 g.updated_date DESC
                    ) AS rn,
                    wu.first_name,
                    wu.last_name,
                    g.created_date AS date,
                    profile_picture_url AS profile,
                    'https://stg-rr.sportz.io/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || COALESCE(thumbnail, gallery_name) AS thumbnail
                FROM labrr.labrr_gallery g
                JOIN labrr.labrr_web_user wu USING (user_guid)
                WHERE g.status = 1
                  AND (
                        v_hashtag IS NULL
                        OR COALESCE(g.additional_info->>'hashtag', '') ILIKE '%' || v_hashtag || '%'
                      )
            ) b
            WHERE rn BETWEEN v_fromrownumber AND v_torownumber
        ) row;

        RAISE NOTICE 'Output without asset_id : %', p_data;

    END IF;

    RAISE NOTICE 'Final Output : %', p_data;

END;
$$;


--
