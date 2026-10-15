-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_partner
-- Type: TABLE

-- Name: utt_partner; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
