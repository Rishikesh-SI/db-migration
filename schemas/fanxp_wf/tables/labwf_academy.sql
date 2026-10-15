-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_academy
-- Type: TABLE

-- Name: labwf_academy; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
