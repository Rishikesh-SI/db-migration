-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_partner
-- Type: TABLE

-- Name: labstlz_partner; Type: TABLE; Schema: labstlz; Owner: -
--

CREATE TABLE labstlz.labstlz_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
