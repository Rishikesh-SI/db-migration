-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_page_data
-- Type: TABLE

-- Name: labdsg_page_data; Type: TABLE; Schema: labdsg; Owner: -
--

CREATE TABLE labdsg.labdsg_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
