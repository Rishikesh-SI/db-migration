-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_cms_tracking_activity
-- Type: TABLE

-- Name: siwaf_cms_tracking_activity; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_cms_tracking_activity (
    tracking_act_id numeric,
    client_id text,
    client_name character varying(2000),
    module_name character varying(2000),
    action_id numeric,
    asset_type_id numeric,
    asset_id numeric,
    asset_title character varying(4000),
    asset_url character varying(4000),
    user_id numeric,
    user_name character varying(2000),
    updated_date timestamp without time zone,
    current_version_number numeric,
    asset_guid character varying(2000)
);


--
