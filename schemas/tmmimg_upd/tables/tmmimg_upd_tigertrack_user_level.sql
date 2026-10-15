-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_tigertrack_user_level
-- Type: TABLE

-- Name: tmmimg_upd_tigertrack_user_level; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_tigertrack_user_level (
    tigertrack_user_level_id numeric NOT NULL,
    social_user_id character varying(500),
    user_level numeric,
    mail_sent numeric,
    created_date timestamp without time zone
);


--
