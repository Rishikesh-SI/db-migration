-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_page_data
-- Type: TABLE

-- Name: labgmr_page_data; Type: TABLE; Schema: labgmr_01082024; Owner: -
--

CREATE TABLE labgmr_01082024.labgmr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
