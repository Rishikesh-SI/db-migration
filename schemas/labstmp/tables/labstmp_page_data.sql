-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_page_data
-- Type: TABLE

-- Name: labstmp_page_data; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
