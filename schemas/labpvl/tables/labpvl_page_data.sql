-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_page_data
-- Type: TABLE

-- Name: labpvl_page_data; Type: TABLE; Schema: labpvl; Owner: -
--

CREATE TABLE labpvl.labpvl_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
