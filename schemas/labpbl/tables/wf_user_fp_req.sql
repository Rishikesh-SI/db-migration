-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: wf_user_fp_req
-- Type: TABLE

-- Name: wf_user_fp_req; Type: TABLE; Schema: labpbl; Owner: -
--

CREATE TABLE labpbl.wf_user_fp_req (
    cf_user_fbid integer NOT NULL,
    cf_userid numeric,
    fp_status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
