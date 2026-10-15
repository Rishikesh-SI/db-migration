-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_page_data
-- Type: TABLE

-- Name: labmsg_page_data; Type: TABLE; Schema: labmsg; Owner: -
--

CREATE TABLE labmsg.labmsg_page_data (
    page_id numeric,
    alias text,
    data_json jsonb,
    created_date timestamp without time zone
);


--
