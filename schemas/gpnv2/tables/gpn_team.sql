-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_team
-- Type: TABLE

-- Name: gpn_team; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_team (
    team_id numeric NOT NULL,
    team_name character varying(100) NOT NULL,
    source_object_id character varying(20) NOT NULL,
    sport_id numeric
);


--
