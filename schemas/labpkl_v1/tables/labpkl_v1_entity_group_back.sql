-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_entity_group_back
-- Type: TABLE

-- Name: labpkl_v1_entity_group_back; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_entity_group_back (
    entity_group_id numeric,
    waf_entity_group_id numeric,
    client_id numeric,
    group_name character varying(300),
    group_desc character varying(2000),
    created_date timestamp without time zone,
    update_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
