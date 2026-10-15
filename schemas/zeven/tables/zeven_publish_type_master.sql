-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_publish_type_master
-- Type: TABLE

-- Name: zeven_publish_type_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_publish_type_master (
    publish_type_id numeric NOT NULL,
    publish_type_name character varying(50),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    is_active numeric
);


--
