-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_flowix_teams
-- Type: TABLE

-- Name: labdms_flowix_teams; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_flowix_teams (
    team_name character varying(100),
    twitter_handle character varying(200),
    source_object_id text,
    scream_name character varying(100)
);


--
