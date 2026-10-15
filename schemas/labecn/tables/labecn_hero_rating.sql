-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_hero_rating
-- Type: TABLE

-- Name: labecn_hero_rating; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_hero_rating (
    hero_rating_id numeric NOT NULL,
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
