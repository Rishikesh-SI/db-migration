-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_client_league_map
-- Type: TABLE

-- Name: gpn_client_league_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_client_league_map (
    client_league_map_id numeric NOT NULL,
    client_id numeric NOT NULL,
    league_id numeric NOT NULL
);


--
