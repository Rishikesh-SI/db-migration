-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_page_data
-- Type: TABLE

-- Name: labsrk_page_data; Type: TABLE; Schema: labsrk; Owner: -
--

CREATE TABLE labsrk.labsrk_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
