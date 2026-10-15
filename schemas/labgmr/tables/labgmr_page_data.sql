-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_page_data
-- Type: TABLE

-- Name: labgmr_page_data; Type: TABLE; Schema: labgmr; Owner: -
--

CREATE TABLE labgmr.labgmr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
