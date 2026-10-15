-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_institute_category
-- Type: TABLE

-- Name: upy_institute_category; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_institute_category (
    institute_category_id numeric NOT NULL,
    category_name character varying(200),
    parent_id numeric,
    is_active numeric,
    is_deleted numeric
);


--
