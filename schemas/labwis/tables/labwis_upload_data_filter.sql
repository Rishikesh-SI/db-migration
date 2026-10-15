-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_upload_data_filter
-- Type: TABLE

-- Name: labwis_upload_data_filter; Type: TABLE; Schema: labwis; Owner: -
--

CREATE TABLE labwis.labwis_upload_data_filter (
    id integer NOT NULL,
    title character varying(255),
    opt_type numeric,
    map_id numeric
);


--
