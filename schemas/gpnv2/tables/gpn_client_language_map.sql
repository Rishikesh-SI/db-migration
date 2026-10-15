-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_client_language_map
-- Type: TABLE

-- Name: gpn_client_language_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_client_language_map (
    client_language_map_id numeric NOT NULL,
    client_id numeric,
    language_id numeric,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL
);


--
