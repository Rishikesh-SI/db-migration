-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_asset_view_trac
-- Type: TABLE

-- Name: labyho_asset_view_trac; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_asset_view_trac (
    asset_view_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    user_id numeric,
    url text,
    share text,
    viewed_date timestamp without time zone,
    is_action text,
    data_guid character varying(500),
    referral_url text,
    user_agent text,
    user_guid character varying(500),
    guest_guid character varying(500)
);


--
