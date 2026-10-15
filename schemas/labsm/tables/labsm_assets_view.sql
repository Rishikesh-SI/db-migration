-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_assets_view
-- Type: TABLE

-- Name: labsm_assets_view; Type: TABLE; Schema: labsm; Owner: -
--

CREATE TABLE labsm.labsm_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
