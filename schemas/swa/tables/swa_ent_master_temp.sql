-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_ent_master_temp
-- Type: TABLE

-- Name: swa_ent_master_temp; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_ent_master_temp (
    entity_master_id numeric,
    entity_name character varying(2000),
    canonical_url character varying(2000),
    waf_entity_name character varying(2000),
    waf_entity_name_updated character varying(2000),
    waf_entity_name_updated_from_15001 character varying(2000)
);


--
