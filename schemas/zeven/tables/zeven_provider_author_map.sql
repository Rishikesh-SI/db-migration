-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_provider_author_map
-- Type: TABLE

-- Name: zeven_provider_author_map; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_provider_author_map (
    provider_author_map_id numeric NOT NULL,
    content_provider_id numeric NOT NULL,
    author_id numeric NOT NULL,
    author_name character varying(256),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
