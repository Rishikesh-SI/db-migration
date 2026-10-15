-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_module
-- Type: TABLE

-- Name: labgt01_v1_module; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_module (
    module_id numeric NOT NULL,
    module_name character varying,
    version_number numeric,
    module_guid character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    total_count numeric,
    current_count numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric
);


--
