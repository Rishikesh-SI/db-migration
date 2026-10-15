-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_page_data
-- Type: TABLE

-- Name: labwskl_page_data; Type: TABLE; Schema: labwskl; Owner: -
--

CREATE TABLE labwskl.labwskl_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
