-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_page_data
-- Type: TABLE

-- Name: lablakr_page_data; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
