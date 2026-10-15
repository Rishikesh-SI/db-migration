-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_uuid_storage
-- Type: TABLE

-- Name: labgt01_v1_uuid_storage; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_uuid_storage (
    uuid_id integer NOT NULL,
    uuid character varying(255),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
