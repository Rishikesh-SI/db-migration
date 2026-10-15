-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_user_client_map
-- Type: TABLE

-- Name: waf_user_client_map; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_user_client_map (
    user_client_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    client_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    ucmap_guid character varying(256) NOT NULL
);


--
