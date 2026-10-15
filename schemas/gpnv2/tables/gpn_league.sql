-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_league
-- Type: TABLE

-- Name: gpn_league; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_league (
    league_id numeric NOT NULL,
    league_name character varying(500) NOT NULL,
    sport_id numeric NOT NULL,
    source_object_id character varying(100),
    for_admin_notification numeric
);


--
