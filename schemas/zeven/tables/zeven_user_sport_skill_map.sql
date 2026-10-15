-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_sport_skill_map
-- Type: TABLE

-- Name: zeven_user_sport_skill_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_sport_skill_map (
    user_sport_skill_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    sport_id numeric NOT NULL,
    skill_level numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
