-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_league
-- Type: TABLE

-- Name: gpn_league; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_league (
    league_id numeric NOT NULL,
    league_name character varying(100) NOT NULL,
    league_code character varying(20) NOT NULL,
    sport_id numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    source_object_id character varying(100),
    for_editorial numeric
);


--
