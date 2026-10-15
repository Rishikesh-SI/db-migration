-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_page_data
-- Type: TABLE

-- Name: labpr_page_data; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
