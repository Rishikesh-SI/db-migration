-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_entity_master_31july2023
-- Type: TABLE

-- Name: labisl_v1_entity_master_31july2023; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_entity_master_31july2023 (
    entity_master_id numeric,
    waf_entity_master_id numeric,
    client_id numeric,
    entity_name character varying(3000),
    entity_display_name character varying(4000),
    canonical_url text,
    priority numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    date_info timestamp without time zone,
    city character varying(4000),
    country numeric,
    known_as character varying(4000),
    comp_type numeric,
    waf_series_master_id numeric,
    waf_tour_master_id numeric,
    entity_guid character varying(256),
    wafc_entity_name character varying(3000),
    wafc_entity_display_name character varying(4000),
    image_available numeric,
    player_image_path text,
    entity_url character varying,
    show_data numeric,
    show_content numeric,
    is_defualt_lang numeric
);


--
