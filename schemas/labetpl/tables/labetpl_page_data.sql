-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_page_data
-- Type: TABLE

-- Name: labetpl_page_data; Type: TABLE; Schema: labetpl; Owner: -
--

CREATE TABLE labetpl.labetpl_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
