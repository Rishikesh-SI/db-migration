-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_fan_wall
-- Type: TABLE

-- Name: isl_fan_wall; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_fan_wall (
    user_guid character varying(250) NOT NULL,
    team_id numeric NOT NULL,
    match_id numeric NOT NULL,
    registered_date timestamp without time zone NOT NULL
);


--
