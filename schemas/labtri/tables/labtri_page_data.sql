-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_page_data
-- Type: TABLE

-- Name: labtri_page_data; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
