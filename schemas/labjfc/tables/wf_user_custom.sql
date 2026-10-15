-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: wf_user_custom
-- Type: TABLE

-- Name: wf_user_custom; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.wf_user_custom (
    cf_custom_userid numeric NOT NULL,
    cf_clientid numeric,
    email_id character varying(255),
    user_password character varying(255),
    upper_email_id character varying(500),
    full_name character varying(255),
    cf_fav_teamid numeric,
    created_date_ist timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
