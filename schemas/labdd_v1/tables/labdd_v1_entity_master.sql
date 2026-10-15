-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_entity_master
-- Type: TABLE

-- Name: labdd_v1_entity_master; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_entity_master (
    entity_master_id numeric NOT NULL,
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
    parent_entity_master_id numeric,
    ent_ordering numeric,
    is_default_lang numeric,
    show_content numeric,
    show_data numeric,
    entity_url character varying(300),
    player_image_path character varying,
    entity_count numeric,
    add_info jsonb,
    show_standings numeric,
    is_add_info boolean
);


--
