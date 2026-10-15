-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_batch_map
-- Type: TABLE

-- Name: labbsc_dev_user_batch_map; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_batch_map (
    user_batch_map_id numeric NOT NULL,
    batch_id numeric NOT NULL,
    user_guid character varying(500),
    created_date timestamp without time zone
);


--
