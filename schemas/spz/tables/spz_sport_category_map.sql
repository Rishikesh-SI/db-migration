-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_sport_category_map
-- Type: TABLE

-- Name: spz_sport_category_map; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_sport_category_map (
    sport_category_map_id numeric NOT NULL,
    institute_category_id numeric,
    sport_entity_role_map_id numeric
);


--
