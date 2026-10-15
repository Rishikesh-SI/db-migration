-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_assets_view
-- Type: TABLE

-- Name: labstrd_assets_view; Type: TABLE; Schema: labstrd; Owner: -
--

CREATE TABLE labstrd.labstrd_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
