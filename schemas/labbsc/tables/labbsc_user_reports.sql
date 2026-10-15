-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_reports
-- Type: TABLE

-- Name: labbsc_user_reports; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_reports (
    user_id numeric,
    report_type numeric,
    report_url text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
