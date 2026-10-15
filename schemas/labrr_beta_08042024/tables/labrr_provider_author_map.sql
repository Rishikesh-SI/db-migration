-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_provider_author_map
-- Type: TABLE

-- Name: labrr_provider_author_map; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_provider_author_map (
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
