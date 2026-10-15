-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_partner
-- Type: TABLE

-- Name: labupw_partner; Type: TABLE; Schema: labupw; Owner: -
--

CREATE TABLE labupw.labupw_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
