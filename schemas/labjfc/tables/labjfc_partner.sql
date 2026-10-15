-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_partner
-- Type: TABLE

-- Name: labjfc_partner; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.labjfc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
