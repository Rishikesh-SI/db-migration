-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_partner
-- Type: TABLE

-- Name: pcm_partner; Type: TABLE; Schema: pcm; Owner: -
--

CREATE TABLE pcm.pcm_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
