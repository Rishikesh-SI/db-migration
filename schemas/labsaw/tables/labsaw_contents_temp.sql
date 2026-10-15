-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_contents_temp
-- Type: TABLE

-- Name: labsaw_contents_temp; Type: TABLE; Schema: labsaw; Owner: -
--

CREATE TABLE labsaw.labsaw_contents_temp (
    asset_id numeric,
    asset_type_id numeric,
    asset_title text,
    entity_name text,
    entity_type text,
    sport text,
    entity_role_map_id numeric,
    is_processed numeric
);


--
