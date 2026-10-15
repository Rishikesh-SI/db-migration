-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_partner
-- Type: TABLE

-- Name: labwf_partner; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_partner (
    partner_id numeric NOT NULL,
    client_name character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
