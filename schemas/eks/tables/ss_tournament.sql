-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tournament
-- Type: TABLE

-- Name: ss_tournament; Type: TABLE; Schema: eks; Owner: -
--

CREATE TABLE eks.ss_tournament (
    cf_tournamentid integer DEFAULT nextval('eks.ss_tournament_cf_tournamentid_seq'::regclass) NOT NULL,
    tournament_name character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
