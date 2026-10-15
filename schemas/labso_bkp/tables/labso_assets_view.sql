-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_assets_view
-- Type: TABLE

-- Name: labso_assets_view; Type: TABLE; Schema: labso_bkp; Owner: -
--

CREATE TABLE labso_bkp.labso_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
