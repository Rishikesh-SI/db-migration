-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_uuid_storage
-- Type: TABLE

-- Name: labkxip_uuid_storage; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_uuid_storage (
    uuid_id integer DEFAULT nextval('labkxip.labkxip_uuid_storage_uuid_id_seq'::regclass) NOT NULL,
    uuid character varying(255) NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP),
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP)
);


--
