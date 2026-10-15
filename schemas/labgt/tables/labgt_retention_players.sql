-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_retention_players
-- Type: TABLE

-- Name: labgt_retention_players; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_retention_players (
    player_id numeric NOT NULL,
    player_name character varying(255),
    count numeric,
    count_2026 numeric
);


--
