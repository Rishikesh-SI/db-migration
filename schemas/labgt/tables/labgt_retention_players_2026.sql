-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_retention_players_2026
-- Type: TABLE

-- Name: labgt_retention_players_2026; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_retention_players_2026 (
    id bigint DEFAULT nextval('labgt.seq_labgt_retention_players_2026_id'::regclass) NOT NULL,
    player_id numeric NOT NULL,
    player_name character varying(255),
    skill_id integer,
    skill character varying(100),
    nationality_id integer,
    nationality character varying(100),
    national_team_id integer,
    national_team character varying(100),
    count numeric,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
