-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: labmcfc_partner
-- Type: TABLE

-- Name: labmcfc_partner; Type: TABLE; Schema: labmcfc; Owner: -
--

CREATE TABLE labmcfc.labmcfc_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
