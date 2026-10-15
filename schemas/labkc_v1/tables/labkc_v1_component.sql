-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_component
-- Type: TABLE

-- Name: labkc_v1_component; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_component (
    component_id numeric NOT NULL,
    title character varying(500),
    component_desc character varying(1000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    component_guid character varying(256),
    composition jsonb
);


--
