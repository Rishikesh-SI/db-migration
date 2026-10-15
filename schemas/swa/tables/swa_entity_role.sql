-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_entity_role
-- Type: TABLE

-- Name: swa_entity_role; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_entity_role (
    entity_role_id numeric NOT NULL,
    entity_type_id numeric NOT NULL,
    entity_group_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
