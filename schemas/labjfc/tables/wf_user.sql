-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: wf_user
-- Type: TABLE

-- Name: wf_user; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.wf_user (
    cf_userid numeric NOT NULL,
    social_id character varying(500),
    cf_clientid numeric,
    email_id character varying(255),
    full_name character varying(255),
    cf_fav_teamid numeric,
    user_guid character varying(1000),
    mobile_no numeric,
    created_date_ist timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
