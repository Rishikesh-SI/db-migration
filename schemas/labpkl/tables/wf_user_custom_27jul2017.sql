-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: wf_user_custom_27jul2017
-- Type: TABLE

-- Name: wf_user_custom_27jul2017; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.wf_user_custom_27jul2017 (
    cf_custom_userid numeric(30,0),
    cf_clientid numeric(10,0),
    email_id character varying(255),
    user_password character varying(255),
    upper_email_id character varying(500),
    full_name character varying(255),
    cf_fav_teamid numeric(10,0),
    created_date_ist timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
