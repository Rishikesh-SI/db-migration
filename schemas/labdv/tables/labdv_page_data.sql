-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_page_data
-- Type: TABLE

-- Name: labdv_page_data; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
