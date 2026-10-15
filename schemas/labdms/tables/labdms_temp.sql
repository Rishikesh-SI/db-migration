-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_temp
-- Type: TABLE

-- Name: labdms_temp; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_temp (
    asset_id numeric,
    asset_type_id numeric,
    url text,
    user_guid character varying(500),
    guest_guid character varying(500),
    action_type text,
    action_url text,
    action_date timestamp without time zone,
    guid character varying(500),
    referral_url text,
    user_agent text,
    action_year numeric,
    action_year_month numeric
);


--
