-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_partner
-- Type: TABLE

-- Name: labgg_partner; Type: TABLE; Schema: labgg; Owner: -
--

CREATE TABLE labgg.labgg_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
