-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_entity_role
-- Type: TABLE

-- Name: labal_nassr_entity_role; Type: TABLE; Schema: labal_nassr; Owner: -
--

CREATE TABLE labal_nassr.labal_nassr_entity_role (
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
