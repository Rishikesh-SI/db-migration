-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_team
-- Type: TABLE

-- Name: gpn_team; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_team (
    team_id numeric NOT NULL,
    team_name character varying(100) NOT NULL,
    team_code character varying(10) NOT NULL,
    sport_id numeric NOT NULL,
    source_object_id character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
