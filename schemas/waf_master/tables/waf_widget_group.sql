-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_widget_group
-- Type: TABLE

-- Name: waf_widget_group; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_widget_group (
    widget_group_id numeric NOT NULL,
    widget_group_name character varying(1000) NOT NULL,
    widget_group_desc character varying(1000) NOT NULL,
    order_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    widget_group_guid character varying(256)
);


--
