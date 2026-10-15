-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_page_data
-- Type: TABLE

-- Name: labgfg_page_data; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
