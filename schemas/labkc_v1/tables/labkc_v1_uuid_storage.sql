-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_uuid_storage
-- Type: TABLE

-- Name: labkc_v1_uuid_storage; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_uuid_storage (
    uuid_id integer DEFAULT nextval('labkc_v1.labkc_v1_uuid_storage_uuid_id_seq'::regclass) NOT NULL,
    uuid character varying(255) NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP),
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP)
);


--
