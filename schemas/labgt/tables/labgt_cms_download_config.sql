-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_cms_download_config
-- Type: TABLE

-- Name: labgt_cms_download_config; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_cms_download_config (
    id integer NOT NULL,
    module_name text NOT NULL,
    opt_type integer,
    dedup_field text DEFAULT 'mobile_no'::text NOT NULL,
    exact_scenario_count integer,
    target_table text,
    use_user_filter_data boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
