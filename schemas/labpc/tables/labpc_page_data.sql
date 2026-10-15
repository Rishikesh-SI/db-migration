-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_page_data
-- Type: TABLE

-- Name: labpc_page_data; Type: TABLE; Schema: labpc; Owner: -
--

CREATE TABLE labpc.labpc_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
