-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_assets_view
-- Type: TABLE

-- Name: labbr_assets_view; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
