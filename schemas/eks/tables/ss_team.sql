-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_team
-- Type: TABLE

-- Name: ss_team; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_team (
    cf_teamid numeric(25,0) NOT NULL,
    team_name character varying(255) NOT NULL,
    team_short_name character varying(100) NOT NULL,
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
