-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_entity_type_29052024
-- Type: TABLE

-- Name: labecn_v1_entity_type_29052024; Type: TABLE; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE TABLE labecn_v1_bkp_29012025.labecn_v1_entity_type_29052024 (
    entity_type_id numeric,
    waf_entity_type_id numeric,
    client_id numeric,
    entity_type_name character varying(1500),
    entity_type_desc character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    entity_type_identifier character varying(1500),
    search_priority numeric,
    is_child numeric,
    is_url numeric,
    entity_url_type numeric
);


--
