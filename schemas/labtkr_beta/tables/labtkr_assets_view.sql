-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_assets_view
-- Type: TABLE

-- Name: labtkr_assets_view; Type: TABLE; Schema: labtkr_beta; Owner: -
--

CREATE TABLE labtkr_beta.labtkr_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
