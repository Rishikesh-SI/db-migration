-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_user_sport_map
-- Type: TABLE

-- Name: zeven_user_sport_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_user_sport_map (
    user_id numeric NOT NULL,
    sportid numeric NOT NULL,
    skill_level numeric NOT NULL,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now()
);


--
