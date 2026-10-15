-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_page_data
-- Type: TABLE

-- Name: labgrl_page_data; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
