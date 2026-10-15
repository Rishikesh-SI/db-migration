-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_partner
-- Type: TABLE

-- Name: labukk_partner; Type: TABLE; Schema: labukk; Owner: -
--

CREATE TABLE labukk.labukk_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
