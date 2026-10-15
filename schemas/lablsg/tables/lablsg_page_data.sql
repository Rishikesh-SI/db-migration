-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_page_data
-- Type: TABLE

-- Name: lablsg_page_data; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
