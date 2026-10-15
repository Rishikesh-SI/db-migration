-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_assets_view
-- Type: TABLE

-- Name: labw88_assets_view; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
