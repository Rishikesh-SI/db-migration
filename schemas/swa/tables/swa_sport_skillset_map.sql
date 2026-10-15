-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_sport_skillset_map
-- Type: TABLE

-- Name: swa_sport_skillset_map; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_sport_skillset_map (
    sport_skillset_map_id numeric NOT NULL,
    sport_id numeric NOT NULL,
    skill_set_1 character varying(4000),
    skill_set_2 character varying(4000),
    skill_set_3 character varying(4000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
