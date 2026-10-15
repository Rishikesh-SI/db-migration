-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: wf_user_fp_req
-- Type: TABLE

-- Name: wf_user_fp_req; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.wf_user_fp_req (
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
