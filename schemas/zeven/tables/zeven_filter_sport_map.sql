-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_filter_sport_map
-- Type: TABLE

-- Name: zeven_filter_sport_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_filter_sport_map (
    zeven_filter_sport_mapid numeric NOT NULL,
    filter_masterid numeric NOT NULL,
    sport_masterid numeric NOT NULL,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now()
);


--
