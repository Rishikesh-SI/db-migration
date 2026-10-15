-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_entity_group_07062024
-- Type: TABLE

-- Name: labecn_v1_entity_group_07062024; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_entity_group_07062024 (
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
    is_deleted numeric,
    is_child numeric
);


--
