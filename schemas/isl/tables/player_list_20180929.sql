-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: player_list_20180929
-- Type: TABLE

-- Name: player_list_20180929; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.player_list_20180929 (
    player_name character varying(1000),
    source_id character varying(100),
    team_name character varying(1000),
    team_id numeric,
    position_name character varying(1000),
    position_id numeric,
    jersey_number numeric,
    is_captain numeric,
    country character varying(1000),
    country_id numeric
);


--
