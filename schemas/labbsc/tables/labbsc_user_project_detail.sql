-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_project_detail
-- Type: TABLE

-- Name: labbsc_user_project_detail; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_project_detail (
    user_project_id numeric NOT NULL,
    user_id numeric,
    project_id numeric,
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
    upload_file jsonb,
    project_complete numeric
);


--
