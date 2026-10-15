-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_page_data
-- Type: TABLE

-- Name: labos_page_data; Type: TABLE; Schema: labos; Owner: -
--

CREATE TABLE labos.labos_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
