-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ent_series
-- Type: TABLE

-- Name: ent_series; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.ent_series (
    entity_role_map_id numeric,
    entity_role_id numeric,
    type_name character varying(200),
    entity_name character varying(200),
    canonical_url character varying(200),
    entity_display_name character varying(200),
    sports character varying(200)
);


--
