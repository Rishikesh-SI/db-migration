-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_page_data
-- Type: TABLE

-- Name: labbr_page_data; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
