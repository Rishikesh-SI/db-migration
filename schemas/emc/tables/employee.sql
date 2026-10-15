-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: emc
-- Object: employee
-- Type: TABLE

-- Name: employee; Type: TABLE; Schema: emc; Owner: -
--

CREATE TABLE emc.employee (
    employee_id numeric NOT NULL,
    employee_name character varying,
    department_id numeric,
    dateofjoining date,
    dateofleaving date,
    image_file_name character varying,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    created_date timestamp with time zone,
    updated_date timestamp with time zone
);


--
