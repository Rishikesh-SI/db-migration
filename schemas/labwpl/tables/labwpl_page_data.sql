-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_page_data
-- Type: TABLE

-- Name: labwpl_page_data; Type: TABLE; Schema: labwpl; Owner: -
--

CREATE TABLE labwpl.labwpl_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
