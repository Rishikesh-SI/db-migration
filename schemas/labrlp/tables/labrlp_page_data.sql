-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_page_data
-- Type: TABLE

-- Name: labrlp_page_data; Type: TABLE; Schema: labrlp; Owner: -
--

CREATE TABLE labrlp.labrlp_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
