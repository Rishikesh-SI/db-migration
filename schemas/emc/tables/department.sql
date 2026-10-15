-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: emc
-- Object: department
-- Type: TABLE

-- Name: department; Type: TABLE; Schema: emc; Owner: -
--

CREATE TABLE emc.department (
    department_id numeric NOT NULL,
    department_name character varying,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp with time zone,
    updated_date timestamp with time zone
);


--
