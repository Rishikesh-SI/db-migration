-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_gallery_listing_web_r_hastag(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_gallery_listing_web_r_hastag(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_gallery_listing_web_r_hastag(p_input jsonb, OUT p_data jsonb) RETURNS jsonb
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
	
	select * from  labgt.labgt_get_gallery_listing_web_r_hastag(
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

BEGIN

    SELECT
        p_input->>'pgnum',
        p_input->>'inum',
        NULLIF(p_input->>'asset_id', ''),
        NULLIF(p_input->>'asset_type_id', ''),
        NULLIF(TRIM(p_input->>'hashtag'), '')
    INTO
        v_pagenumber,
        v_itemnumber,
        v_asset_id,
        v_asset_type_id,
        v_hashtag;

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
                    'https://www.gujarattitansipl.com/static-assets/'
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
                    'https://www.gujarattitansipl.com/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || COALESCE(thumbnail, gallery_name) AS thumbnail
                FROM labgt.labgt_gallery g
                JOIN labgt.labgt_web_user wu USING (user_guid)
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
                        'https://www.gujarattitansipl.com/static-assets/'
                            || gallery_path || '/'
                            || COALESCE(user_guid, '') || '/'
                            || is_gif_created || '/'
                            || gallery_name AS url,
                        gallery_id,
                        ROW_NUMBER() OVER (
                            ORDER BY is_fav_comment DESC, g.updated_date DESC
                        ) AS rn,
                        wu.first_name,
                        wu.last_name,
                        g.created_date AS date,
                        profile_picture_url AS profile,
                        'https://www.gujarattitansipl.com/static-assets/'
                            || gallery_path || '/'
                            || COALESCE(user_guid, '') || '/'
                            || is_gif_created || '/'
                            || COALESCE(thumbnail, gallery_name) AS thumbnail
                    FROM labgt.labgt_gallery g
                    JOIN labgt.labgt_web_user wu USING (user_guid)
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
                    'https://www.gujarattitansipl.com/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || gallery_name AS url,
                    gallery_id,
                    ROW_NUMBER() OVER (
                        ORDER BY is_fav_comment DESC, g.updated_date DESC
                    ) AS rn,
                    wu.first_name,
                    wu.last_name,
                    g.created_date AS date,
                    profile_picture_url AS profile,
                    'https://www.gujarattitansipl.com/static-assets/'
                        || gallery_path || '/'
                        || COALESCE(user_guid, '') || '/'
                        || is_gif_created || '/'
                        || COALESCE(thumbnail, gallery_name) AS thumbnail
                FROM labgt.labgt_gallery g
                JOIN labgt.labgt_web_user wu USING (user_guid)
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
