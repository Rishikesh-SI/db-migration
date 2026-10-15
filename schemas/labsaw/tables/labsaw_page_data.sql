-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_page_data
-- Type: TABLE

-- Name: labsaw_page_data; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
