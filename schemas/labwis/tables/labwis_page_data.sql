-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_page_data
-- Type: TABLE

-- Name: labwis_page_data; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
