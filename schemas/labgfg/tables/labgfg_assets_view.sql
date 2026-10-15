-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_assets_view
-- Type: TABLE

-- Name: labgfg_assets_view; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
