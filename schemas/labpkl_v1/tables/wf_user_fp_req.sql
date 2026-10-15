-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_fp_req
-- Type: TABLE

-- Name: wf_user_fp_req; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.wf_user_fp_req (
    cf_user_fbid integer NOT NULL,
    cf_user_fp_reqid character varying NOT NULL,
    cf_userid numeric,
    email_id character varying,
    old_password character varying,
    new_password character varying,
    fp_status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
