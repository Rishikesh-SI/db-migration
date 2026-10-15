-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_job_profile
-- Type: TABLE

-- Name: labbsc_dev_job_profile; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_job_profile (
    job_profile_id numeric,
    job_profile text,
    slug_url text,
    job_id text,
    tot_exp text,
    job_desc text,
    job_location text,
    job_function text,
    job_type text,
    asset_type_id numeric,
    created_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    updated_date timestamp without time zone,
    job_guid character varying(200),
    tag_entity integer[],
    pub_date timestamp without time zone,
    email_id character varying(1000),
    version_number numeric,
    is_trashed numeric,
    is_published numeric,
    tagged_entity integer[],
    job_exp timestamp without time zone,
    company_name numeric,
    do_not_expired numeric,
    test_id numeric,
    job_summary text,
    job_category character varying(500),
    joining_date character varying(500),
    minimum_salary character varying(500),
    maximum_salary character varying(500),
    company_website text,
    suggested_companies text,
    suggested_industries text,
    miscellaneous_info text,
    reporting_to text,
    good_to_have_skill text,
    must_have_skills text,
    work_on_weekends character varying(500),
    hours_per_week character varying(500),
    age_bracket character varying(500),
    job_status numeric,
    upload_flag numeric,
    description text,
    min_experience character varying(500),
    max_experience character varying(500),
    job_closing_date timestamp without time zone
);


--
