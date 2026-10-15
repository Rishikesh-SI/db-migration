-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_assets_view
-- Type: TABLE

-- Name: cli_stp_v1_assets_view; Type: TABLE; Schema: cli_stp_v1; Owner: -
--

CREATE TABLE cli_stp_v1.cli_stp_v1_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
