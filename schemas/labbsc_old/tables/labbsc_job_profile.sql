-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_job_profile
-- Type: TABLE

-- Name: labbsc_job_profile; Type: TABLE; Schema: labbsc_old; Owner: -
--

CREATE TABLE labbsc_old.labbsc_job_profile (
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
    company_name text,
    do_not_expired numeric,
    test_id numeric
);


--
