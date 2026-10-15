-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_retention_players
-- Type: TABLE

-- Name: labgt01_v1_retention_players; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_retention_players (
    player_id numeric NOT NULL,
    player_name character varying(255),
    count numeric,
    count_2026 numeric
);


--
