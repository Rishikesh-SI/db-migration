-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_page_data
-- Type: TABLE

-- Name: labgg_page_data; Type: TABLE; Schema: labgg; Owner: -
--

CREATE TABLE labgg.labgg_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
