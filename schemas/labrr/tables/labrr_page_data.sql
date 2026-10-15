-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_page_data
-- Type: TABLE

-- Name: labrr_page_data; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
