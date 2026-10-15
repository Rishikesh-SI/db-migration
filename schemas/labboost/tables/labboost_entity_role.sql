-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labboost
-- Object: labboost_entity_role
-- Type: TABLE

-- Name: labboost_entity_role; Type: TABLE; Schema: labboost; Owner: -
--

CREATE TABLE labboost.labboost_entity_role (
    entity_role_id numeric NOT NULL,
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
