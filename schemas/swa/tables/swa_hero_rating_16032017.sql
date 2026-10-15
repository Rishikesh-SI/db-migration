-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_hero_rating_16032017
-- Type: TABLE

-- Name: swa_hero_rating_16032017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_hero_rating_16032017 (
    hero_rating_id numeric,
    entity_role_map_id numeric,
    sport_id numeric,
    role_text character varying(500),
    asset_text text,
    asset_title character varying(4000),
    player_name character varying(500),
    player_display_name character varying(500),
    rating numeric,
    rating_week_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    asset_guid character varying(256),
    language_id numeric
);


--
