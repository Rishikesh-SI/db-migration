-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_reports
-- Type: TABLE

-- Name: labbsc_dev_user_reports; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_reports (
    user_id numeric,
    report_type numeric,
    report_url text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
