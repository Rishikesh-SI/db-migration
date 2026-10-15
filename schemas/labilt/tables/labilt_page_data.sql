-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_page_data
-- Type: TABLE

-- Name: labilt_page_data; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
