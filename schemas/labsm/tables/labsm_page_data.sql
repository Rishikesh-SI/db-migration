-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_page_data
-- Type: TABLE

-- Name: labsm_page_data; Type: TABLE; Schema: labsm; Owner: -
--

CREATE TABLE labsm.labsm_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
