-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_tigertrack_user_level
-- Type: TABLE

-- Name: tmm_tigertrack_user_level; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_tigertrack_user_level (
    tigertrack_user_level_id numeric NOT NULL,
    social_user_id character varying(500),
    user_level numeric,
    mail_sent numeric,
    created_date timestamp without time zone
);


--
