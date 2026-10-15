-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_page_data
-- Type: TABLE

-- Name: labmi_v1_page_data; Type: TABLE; Schema: labmi_v1_bkp; Owner: -
--

CREATE TABLE labmi_v1_bkp.labmi_v1_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
