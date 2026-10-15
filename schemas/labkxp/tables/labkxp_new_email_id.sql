-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp
-- Object: labkxp_new_email_id
-- Type: TABLE

-- Name: labkxp_new_email_id; Type: TABLE; Schema: labkxp; Owner: -
--

CREATE TABLE labkxp.labkxp_new_email_id (
    email_id character varying(100),
    user_guid character varying(256),
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
