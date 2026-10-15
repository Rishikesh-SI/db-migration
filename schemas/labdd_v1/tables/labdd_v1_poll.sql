-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_poll
-- Type: TABLE

-- Name: labdd_v1_poll; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_poll (
    poll_id numeric NOT NULL,
    alias character varying,
    title character varying,
    poll_desc character varying,
    poll_type numeric,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    meta_info jsonb,
    image_url character varying(3000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    poll_guid character varying(256),
    show_in_app numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    slug_url character varying(4000),
    is_trashed numeric,
    checked_out_by numeric,
    checked_out_date timestamp without time zone,
    no_of_ans_allowed numeric,
    correct_ans_id numeric,
    is_cal_proceed numeric
);


--
