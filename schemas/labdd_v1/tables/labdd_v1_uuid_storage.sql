-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_uuid_storage
-- Type: TABLE

-- Name: labdd_v1_uuid_storage; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_uuid_storage (
    uuid_id integer NOT NULL,
    uuid character varying(255) NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP),
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP)
);


--
