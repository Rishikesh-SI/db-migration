-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_retention_players_2026
-- Type: TABLE

-- Name: labgt01_v1_retention_players_2026; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_retention_players_2026 (
    id bigint NOT NULL,
    player_id numeric,
    player_name character varying(255),
    skill_id integer,
    skill character varying(100),
    nationality_id integer,
    nationality character varying(100),
    national_team_id integer,
    national_team character varying(100),
    count numeric,
    created_at timestamp without time zone
);


--
