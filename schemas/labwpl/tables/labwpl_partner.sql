-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_partner
-- Type: TABLE

-- Name: labwpl_partner; Type: TABLE; Schema: labwpl; Owner: -
--

CREATE TABLE labwpl.labwpl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
