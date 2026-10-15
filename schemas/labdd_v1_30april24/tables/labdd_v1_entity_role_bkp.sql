-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_entity_role_bkp
-- Type: TABLE

-- Name: labdd_v1_entity_role_bkp; Type: TABLE; Schema: labdd_v1_30april24; Owner: -
--

CREATE TABLE labdd_v1_30april24.labdd_v1_entity_role_bkp (
    entity_role_id numeric,
    entity_type_id numeric,
    entity_group_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
