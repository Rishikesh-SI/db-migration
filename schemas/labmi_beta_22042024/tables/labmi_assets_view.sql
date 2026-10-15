-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_assets_view
-- Type: TABLE

-- Name: labmi_assets_view; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_assets_view (
    assets_view_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    view_date timestamp without time zone,
    view_count numeric
);


--
