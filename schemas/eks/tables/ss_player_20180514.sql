-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_20180514
-- Type: TABLE

-- Name: ss_player_20180514; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_player_20180514 (
    cf_playerid numeric(25,0),
    first_name character varying(500),
    last_name character varying(500),
    cf_skillid numeric(10,0),
    cf_countryid numeric(10,0),
    is_active numeric(1,0),
    is_deleted numeric(1,0),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
