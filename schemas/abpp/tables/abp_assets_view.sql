-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_assets_view
-- Type: TABLE

-- Name: abp_assets_view; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    view_date timestamp without time zone,
    view_count numeric
);


--
