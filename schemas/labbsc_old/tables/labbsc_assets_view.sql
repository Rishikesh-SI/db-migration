-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_assets_view
-- Type: TABLE

-- Name: labbsc_assets_view; Type: TABLE; Schema: labbsc_old; Owner: -
--

CREATE TABLE labbsc_old.labbsc_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
