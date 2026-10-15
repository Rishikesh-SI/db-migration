-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_sea_5_match_data
-- Type: TABLE

-- Name: labpkl_sea_5_match_data; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_sea_5_match_data (
    match_id numeric,
    team1_id numeric,
    team1_name character varying(200),
    team1_match_short_code character varying(200),
    team1_alias character varying(200),
    team2_id numeric,
    team2_name character varying(200),
    team2_match_short_code character varying(200),
    team2_alias character varying(200),
    match_no character varying(200),
    matchdate_gmt date
);


--
