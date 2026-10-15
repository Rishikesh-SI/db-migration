-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_institute_category_sport_map
-- Type: TABLE

-- Name: upy_institute_category_sport_map; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_institute_category_sport_map (
    institute_category_sport_map_id numeric NOT NULL,
    institute_id numeric,
    institute_category_id numeric,
    sport_id numeric,
    entity_role_id numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
