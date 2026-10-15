-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_provider_author_map
-- Type: TABLE

-- Name: labtkr_provider_author_map; Type: TABLE; Schema: labtkr; Owner: -
--

CREATE TABLE labtkr.labtkr_provider_author_map (
    provider_author_map_id numeric NOT NULL,
    content_provider_id numeric,
    author_id numeric,
    author_name character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
