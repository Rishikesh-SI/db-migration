-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_assets_view
-- Type: TABLE

-- Name: labmao_assets_view; Type: TABLE; Schema: labmao; Owner: -
--

CREATE TABLE labmao.labmao_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
