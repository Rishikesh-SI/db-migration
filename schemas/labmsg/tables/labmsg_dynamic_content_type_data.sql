-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_dynamic_content_type_data
-- Type: TABLE

-- Name: labmsg_dynamic_content_type_data; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_dynamic_content_type_data (
    dynamic_content_type_data_id numeric,
    title character varying,
    title_alias character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    published_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    ct_guid character varying,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric,
    published_version_number numeric,
    asset_meta jsonb,
    content_type_id numeric
);


--
