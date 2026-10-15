-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_placed_user
-- Type: TABLE

-- Name: labbsc_dev_placed_user; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_placed_user (
    upload_user_id numeric NOT NULL,
    candidate_name text,
    role_name character varying(500),
    company_name text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
