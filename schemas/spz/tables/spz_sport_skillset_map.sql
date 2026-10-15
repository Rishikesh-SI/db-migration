-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_sport_skillset_map
-- Type: TABLE

-- Name: spz_sport_skillset_map; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_sport_skillset_map (
    sport_skillset_map_id numeric NOT NULL,
    sport_id numeric,
    skill_set_1 character varying(4000),
    skill_set_2 character varying(4000),
    skill_set_3 character varying(4000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
