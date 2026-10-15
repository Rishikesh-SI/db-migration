-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_fp_req_27jul2017
-- Type: TABLE

-- Name: wf_user_fp_req_27jul2017; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.wf_user_fp_req_27jul2017 (
    cf_user_fbid integer,
    cf_user_fp_reqid character varying,
    cf_userid numeric,
    email_id character varying,
    old_password character varying,
    new_password character varying,
    fp_status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
