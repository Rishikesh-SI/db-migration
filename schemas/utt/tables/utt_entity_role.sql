-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_entity_role
-- Type: TABLE

-- Name: utt_entity_role; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_entity_role (
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
