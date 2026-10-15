-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_user_acess_token
-- Type: TABLE

-- Name: labkkr_user_acess_token; Type: TABLE; Schema: labkkr_beta; Owner: -
--

CREATE TABLE labkkr_beta.labkkr_user_acess_token (
    user_id numeric,
    user_guid text,
    client numeric,
    access_token text,
    created_date timestamp without time zone,
    social_id character varying(300),
    long_live_access_token text,
    updated_date timestamp without time zone
);


--
