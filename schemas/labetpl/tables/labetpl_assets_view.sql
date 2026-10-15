-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_assets_view
-- Type: TABLE

-- Name: labetpl_assets_view; Type: TABLE; Schema: labetpl; Owner: -
--

CREATE TABLE labetpl.labetpl_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
