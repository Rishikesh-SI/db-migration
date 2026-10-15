-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_page_data
-- Type: TABLE

-- Name: labal_nassr_page_data; Type: TABLE; Schema: labal_nassr; Owner: -
--

CREATE TABLE labal_nassr.labal_nassr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
