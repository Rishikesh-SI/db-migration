-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_partner
-- Type: TABLE

-- Name: labadkr_partner; Type: TABLE; Schema: labadkr; Owner: -
--

CREATE TABLE labadkr.labadkr_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
