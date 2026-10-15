-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: labukk_assets_view
-- Type: TABLE

-- Name: labukk_assets_view; Type: TABLE; Schema: labukk; Owner: -
--

CREATE TABLE labukk.labukk_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
