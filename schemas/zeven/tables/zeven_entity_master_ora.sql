-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_entity_master_ora
-- Type: TABLE

-- Name: zeven_entity_master_ora; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_entity_master_ora (
    entity_master_id numeric NOT NULL,
    entity_name character varying(1000) NOT NULL,
    entity_display_name text,
    canonical_url text,
    priority numeric,
    created_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_delete numeric NOT NULL,
    big_image character varying(1000),
    small_image character varying(1000),
    profile_text text,
    date_info timestamp without time zone,
    city character varying(1000),
    country character varying(1000),
    known_as character varying(1000),
    fb_url character varying(1000),
    twtr_url character varying(1000),
    gp_url character varying(1000),
    linkdin_url character varying(1000),
    instragram_url character varying(1000),
    flicker_url character varying(1000),
    nickname character varying(200),
    vimeo character varying(2000),
    youtube character varying(2000),
    jersey_number numeric,
    "position" numeric,
    position_short character varying(100),
    is_international numeric,
    is_marquee numeric,
    is_announced numeric,
    team numeric,
    since timestamp without time zone,
    positions_played character varying(500),
    height_in_meters numeric,
    weight_in_kg numeric,
    international_caps numeric,
    caps numeric,
    major_clubs character varying(4000),
    quote text,
    club_ileague_caps numeric,
    club_ileague_goals numeric,
    nationality numeric,
    cover_photo character varying(2000),
    medium_image character varying(1000),
    si_client_id numeric NOT NULL
);


--
