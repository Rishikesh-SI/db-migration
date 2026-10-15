-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_entity_role_map_29062017
-- Type: TABLE

-- Name: pkl_entity_role_map_29062017; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.pkl_entity_role_map_29062017 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric
);


--
