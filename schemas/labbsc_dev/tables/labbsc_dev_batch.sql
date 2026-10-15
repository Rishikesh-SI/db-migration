-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_batch
-- Type: TABLE

-- Name: labbsc_dev_batch; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_batch (
    batch_id numeric NOT NULL,
    batch_name character varying(300),
    batch_date timestamp without time zone,
    batch_time character varying(500),
    mentor_name_1 character varying(500),
    mentor_email_id_1 character varying(500),
    mentor_name_2 character varying(500),
    mentor_email_id_2 character varying(500),
    total_slots numeric,
    available_slots numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    "position" numeric
);


--
