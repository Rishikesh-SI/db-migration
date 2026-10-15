-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_assets_view
-- Type: TABLE

-- Name: labgt_assets_view; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
