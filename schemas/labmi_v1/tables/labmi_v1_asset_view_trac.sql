-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_asset_view_trac
-- Type: TABLE

-- Name: labmi_v1_asset_view_trac; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_asset_view_trac (
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
