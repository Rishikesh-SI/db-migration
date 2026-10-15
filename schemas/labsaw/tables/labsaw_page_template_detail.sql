-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_page_template_detail
-- Type: TABLE

-- Name: labsaw_page_template_detail; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_page_template_detail (
    page_template_detail_id numeric NOT NULL,
    page_id numeric,
    page_alias text,
    template_id numeric,
    template_name character varying(500),
    template_html text,
    page_info_json jsonb,
    is_updated numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    mobile_html text,
    mobile_page_json jsonb,
    is_responsive numeric,
    parent_id numeric,
    is_amp numeric,
    is_deleted numeric,
    is_published numeric
);


--
