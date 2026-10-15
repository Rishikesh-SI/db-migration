-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: wf_user_27jul2017
-- Type: TABLE

-- Name: wf_user_27jul2017; Type: TABLE; Schema: pkl; Owner: -
--

CREATE TABLE pkl.wf_user_27jul2017 (
    cf_userid numeric(30,0),
    social_id character varying(500),
    cf_clientid numeric(10,0),
    email_id character varying(255),
    full_name character varying(255),
    cf_fav_teamid numeric(10,0),
    user_guid character varying(1000),
    mobile_no numeric(20,0),
    created_date_ist timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
