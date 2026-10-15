-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: hindi_ent_name
-- Type: TABLE

-- Name: hindi_ent_name; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.hindi_ent_name (
    group_name character varying(200),
    entity_role_map_id numeric,
    entity_name character varying(200),
    entity_display_name character varying(200),
    hindi_name character varying(200)
);


--
