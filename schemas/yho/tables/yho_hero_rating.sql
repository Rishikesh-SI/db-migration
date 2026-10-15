-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_hero_rating
-- Type: TABLE

-- Name: yho_hero_rating; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_hero_rating (
    hero_rating_id numeric NOT NULL,
    entity_role_map_id numeric NOT NULL,
    sport_id numeric NOT NULL,
    role_text character varying(500),
    asset_text text,
    asset_title character varying(4000),
    player_name character varying(500) NOT NULL,
    player_display_name character varying(500) NOT NULL,
    rating numeric NOT NULL,
    rating_week_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    asset_guid character varying(256),
    language_id numeric,
    skill_set_1 character varying(4000),
    skill_set_2 character varying(4000),
    skill_set_3 character varying(4000),
    player_dob date,
    player_pob character varying(1000),
    league_code character varying(256),
    league_id character varying(256)
);


--
