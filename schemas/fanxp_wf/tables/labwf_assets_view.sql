-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_assets_view
-- Type: TABLE

-- Name: labwf_assets_view; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
