-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_academy_fee
-- Type: TABLE

-- Name: labwf_academy_fee; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_academy_fee (
    academy_fee_id numeric NOT NULL,
    academy_id numeric,
    academy_name character varying(300),
    fee numeric,
    frequency numeric
);


--
