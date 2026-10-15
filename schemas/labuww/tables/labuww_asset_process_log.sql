-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_asset_process_log
-- Type: TABLE

-- Name: labuww_asset_process_log; Type: TABLE; Schema: labuww; Owner: -
--

CREATE TABLE labuww.labuww_asset_process_log (
    id bigint DEFAULT nextval('labuww.labuww_asset_process_log_id_seq'::regclass) NOT NULL,
    asset_id numeric,
    asset_type numeric NOT NULL,
    status character varying(1000),
    title character varying(4000),
    title_alias character varying(4000),
    short_title character varying(2000),
    meta_data jsonb,
    description text,
    author_id numeric,
    category_id numeric,
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric,
    asset_url character varying(4000),
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    asset_guid character varying(256),
    published_date timestamp without time zone,
    show_copyright numeric,
    content_source_link character varying(4000),
    order_number numeric,
    image_id numeric,
    slug_url character varying(4000),
    checked_out_by numeric,
    checked_out_date timestamp without time zone,
    hls_url character varying(4000),
    azure_id numeric,
    ref_asset_guid character varying,
    ref_asset_id numeric,
    payload jsonb,
    content_source_id numeric
);


--
