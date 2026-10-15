-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_asset_view_trac
-- Type: TABLE

-- Name: labmi_asset_view_trac; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_asset_view_trac (
    asset_view_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    user_id numeric,
    url text,
    share text,
    viewed_date timestamp without time zone,
    is_action text,
    data_guid character varying(500)
);


--
