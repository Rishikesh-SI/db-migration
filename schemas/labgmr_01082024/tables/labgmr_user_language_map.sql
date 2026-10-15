-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_user_language_map
-- Type: TABLE

-- Name: labgmr_user_language_map; Type: TABLE; Schema: labgmr_01082024; Owner: -
--

CREATE TABLE labgmr_01082024.labgmr_user_language_map (
    user_language_map_id numeric NOT NULL,
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
