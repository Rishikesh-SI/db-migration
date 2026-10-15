-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_livelike_users
-- Type: TABLE

-- Name: labgt_livelike_users; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_livelike_users (
    userid character varying(1000),
    llid character varying(1000),
    access_token text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
