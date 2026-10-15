-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: team_list
-- Type: TABLE

-- Name: team_list; Type: TABLE; Schema: msl; Owner: -
--

CREATE TABLE msl.team_list (
    entity_name character varying(100),
    display_name character varying(100),
    known_as character varying(100),
    source_id character varying(100),
    type character varying(100)
);


--
