-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_kid_leaderboard
-- Type: TABLE

-- Name: stn_kid_leaderboard; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_kid_leaderboard (
    kid_leaderboard_id numeric NOT NULL,
    kid_id numeric NOT NULL,
    leaderboard_json jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
