-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_user_activity
-- Type: TABLE

-- Name: utt_user_activity; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    activity_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
