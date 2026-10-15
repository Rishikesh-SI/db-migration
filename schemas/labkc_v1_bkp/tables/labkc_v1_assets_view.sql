-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_assets_view
-- Type: TABLE

-- Name: labkc_v1_assets_view; Type: TABLE; Schema: labkc_v1_bkp; Owner: -
--

CREATE TABLE labkc_v1_bkp.labkc_v1_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
