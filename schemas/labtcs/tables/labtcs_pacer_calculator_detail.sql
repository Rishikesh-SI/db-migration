-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_pacer_calculator_detail
-- Type: TABLE

-- Name: labtcs_pacer_calculator_detail; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_pacer_calculator_detail (
    tsk_pacer_calc_dtl_id numeric NOT NULL,
    pacer_calculator_type character varying(10),
    pacer_name character varying(100),
    pacer_email_id character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
