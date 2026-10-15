-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_page_data
-- Type: TABLE

-- Name: labman_page_data; Type: TABLE; Schema: labman; Owner: -
--

CREATE TABLE labman.labman_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
