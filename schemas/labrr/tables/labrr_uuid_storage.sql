-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_uuid_storage
-- Type: TABLE

-- Name: labrr_uuid_storage; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_uuid_storage (
    uuid_id integer NOT NULL,
    uuid character varying(255) NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP),
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP)
);


--
