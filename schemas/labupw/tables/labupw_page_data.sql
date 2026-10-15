-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_page_data
-- Type: TABLE

-- Name: labupw_page_data; Type: TABLE; Schema: labupw; Owner: -
--

CREATE TABLE labupw.labupw_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
