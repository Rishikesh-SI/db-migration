-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_partner
-- Type: TABLE

-- Name: labfih_partner; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
