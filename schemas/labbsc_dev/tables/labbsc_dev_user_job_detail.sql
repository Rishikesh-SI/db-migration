-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_job_detail
-- Type: TABLE

-- Name: labbsc_dev_user_job_detail; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_job_detail (
    user_job_id numeric NOT NULL,
    user_id numeric,
    job_id numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_active numeric,
    report_url text,
    feedback jsonb,
    status numeric DEFAULT 0,
    video_id numeric,
    company_feedback jsonb,
    save_as_draft_user numeric,
    save_as_draft_company numeric,
    upload_file jsonb
);


--
