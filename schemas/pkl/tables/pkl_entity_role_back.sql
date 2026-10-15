-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_entity_role_back
-- Type: TABLE

-- Name: pkl_entity_role_back; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_entity_role_back (
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
