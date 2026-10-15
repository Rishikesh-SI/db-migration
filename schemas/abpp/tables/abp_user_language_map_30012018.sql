-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_user_language_map_30012018
-- Type: TABLE

-- Name: abp_user_language_map_30012018; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_user_language_map_30012018 (
    user_language_map_id numeric,
    user_id numeric,
    language_master_id numeric,
    user_name character varying(300),
    full_name character varying(300),
    display_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    bio text
);


--
