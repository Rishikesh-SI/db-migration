-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_user_action_tracking_202002
-- Type: TABLE

-- Name: labyho_user_action_tracking_202002; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_user_action_tracking_202002 (
    asset_id numeric,
    asset_type_id numeric,
    url text,
    user_guid character varying(500),
    guest_guid character varying(500),
    action_type text,
    action_url text,
    action_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    guid character varying(500),
    referral_url text,
    user_agent text,
    action_year numeric DEFAULT (date_part('year'::text, CURRENT_TIMESTAMP))::numeric,
    action_year_month numeric DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYYYMM'::text))::numeric
);


--
