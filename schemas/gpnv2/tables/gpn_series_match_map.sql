-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_series_match_map
-- Type: TABLE

-- Name: gpn_series_match_map; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_series_match_map (
    series_map_id numeric NOT NULL,
    series_id numeric NOT NULL,
    match_id numeric,
    source_object_id character varying(500),
    match_json jsonb,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    series_name character varying(500)
);


--
