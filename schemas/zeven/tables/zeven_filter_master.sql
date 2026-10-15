-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_filter_master
-- Type: TABLE

-- Name: zeven_filter_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_filter_master (
    zeven_filter_masterid numeric NOT NULL,
    filter_name character varying(500) NOT NULL,
    display_name character varying(500),
    filter_tablename character varying(500),
    is_active numeric,
    is_deleted numeric,
    is_searchable numeric,
    filter_level numeric,
    parent_filter_id numeric,
    is_leaf_node numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    filter_order numeric,
    is_venue_lvl_filter numeric
);


--
