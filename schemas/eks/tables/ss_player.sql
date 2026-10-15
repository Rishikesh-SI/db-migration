-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player
-- Type: TABLE

-- Name: ss_player; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_player (
    cf_playerid numeric(25,0) NOT NULL,
    first_name character varying(500) NOT NULL,
    last_name character varying(500) NOT NULL,
    cf_skillid numeric(10,0),
    cf_countryid numeric(10,0),
    is_active numeric(1,0) NOT NULL,
    is_deleted numeric(1,0) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
