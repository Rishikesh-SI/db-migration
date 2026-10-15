-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_client
-- Type: TABLE

-- Name: gpn_client; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_client (
    client_id numeric NOT NULL,
    client_name character varying(100) NOT NULL,
    chunk_size numeric NOT NULL,
    maximum_parallel_chunk numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    image_path character varying,
    waf_master_client_id numeric,
    client_code character varying(50),
    object_image_path character varying
);


--
