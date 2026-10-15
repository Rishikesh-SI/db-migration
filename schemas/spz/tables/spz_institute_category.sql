-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_institute_category
-- Type: TABLE

-- Name: spz_institute_category; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_institute_category (
    institute_category_id numeric NOT NULL,
    category_name character varying(200),
    parent_id numeric,
    is_active numeric,
    is_deleted numeric
);


--
