-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_module
-- Type: TABLE

-- Name: labgt_module; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_module (
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
