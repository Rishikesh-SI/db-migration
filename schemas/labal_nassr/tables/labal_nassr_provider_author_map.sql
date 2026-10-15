-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_provider_author_map
-- Type: TABLE

-- Name: labal_nassr_provider_author_map; Type: TABLE; Schema: labal_nassr; Owner: -
--

CREATE TABLE labal_nassr.labal_nassr_provider_author_map (
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
