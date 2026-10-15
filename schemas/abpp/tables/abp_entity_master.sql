-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_entity_master
-- Type: TABLE

-- Name: abp_entity_master; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_entity_master (
    entity_master_id numeric NOT NULL,
    waf_entity_master_id numeric,
    client_id numeric NOT NULL,
    entity_name character varying(3000) NOT NULL,
    entity_display_name character varying(4000),
    canonical_url text,
    priority numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    date_info timestamp without time zone,
    city character varying(4000),
    country numeric,
    known_as character varying(4000),
    comp_type numeric,
    waf_series_master_id numeric,
    waf_tour_master_id numeric,
    entity_guid character varying(256) NOT NULL,
    wafc_entity_name character varying(3000) NOT NULL,
    wafc_entity_display_name character varying(4000),
    image_available numeric,
    entity_url character varying(300)
);


--
