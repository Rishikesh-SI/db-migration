-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_tigertrack_data_19112019
-- Type: TABLE

-- Name: tmmimg_upd_tigertrack_data_19112019; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_tigertrack_data_19112019 (
    tigertrack_data_id numeric,
    bib_number numeric,
    social_user_id character varying(500),
    msg_text text,
    pubisher character varying(250),
    msg_id character varying(500),
    created_date timestamp without time zone,
    user_json jsonb,
    url text,
    media_type text
);


--
