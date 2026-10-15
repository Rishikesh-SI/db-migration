-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: labpbl_partner
-- Type: TABLE

-- Name: labpbl_partner; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.labpbl_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
