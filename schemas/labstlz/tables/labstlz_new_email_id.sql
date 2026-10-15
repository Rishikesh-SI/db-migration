-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: labstlz_new_email_id
-- Type: TABLE

-- Name: labstlz_new_email_id; Type: TABLE; Schema: labstlz; Owner: -
--

CREATE TABLE labstlz.labstlz_new_email_id (
    email_id character varying(100),
    user_guid character varying(256),
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
