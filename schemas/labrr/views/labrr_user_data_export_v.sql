-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_user_data_export_v
-- Type: VIEW

-- Name: labrr_user_data_export_v; Type: VIEW; Schema: labrr; Owner: -
--

CREATE VIEW labrr.labrr_user_data_export_v AS
 SELECT a.user_id,
    a.user_guid,
    a.first_name,
    a.last_name,
    a.email_id,
    a.email_verified,
    a.country_code,
    a.mobile_no,
    a.mobile_verified,
    a.dob,
    a.gender,
    a.city,
    a.pincode,
    a.state_name,
    b.name AS country,
    ( SELECT em.entity_name
           FROM (labrr.labrr_entity_role_map erm
             JOIN labrr.labrr_entity_master em ON ((em.entity_master_id = erm.entity_master_id)))
          WHERE ((erm.source_object_id)::text = (a.favourite_player_id)::text)
          ORDER BY em.entity_name
         LIMIT 1) AS favourite_player,
    a.jersey_number,
    to_char((a.created_date + '05:30:00'::interval), 'YYYY-MM-DD HH24:MI:SS'::text) AS created_date,
    to_char((a.updated_date + '05:30:00'::interval), 'YYYY-MM-DD HH24:MI:SS'::text) AS updated_date
   FROM (labrr.labrr_web_user a
     LEFT JOIN waf_master.waf_countries b ON ((b.country_id = a.country_id)));


--
