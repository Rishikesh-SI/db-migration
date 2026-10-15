-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_custom
-- Type: TABLE

-- Name: wf_user_custom; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.wf_user_custom (
    cf_custom_userid numeric(30,0) NOT NULL,
    cf_clientid numeric(10,0) NOT NULL,
    email_id character varying(255) NOT NULL,
    user_password character varying(255) NOT NULL,
    upper_email_id character varying(500) NOT NULL,
    full_name character varying(255) NOT NULL,
    cf_fav_teamid numeric(10,0) NOT NULL,
    created_date_ist timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
