-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_component
-- Type: TABLE

-- Name: labkxp_component; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_component (
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
