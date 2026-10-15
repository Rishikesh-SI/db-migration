-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_twitter_users
-- Type: TABLE

-- Name: dmfw_twitter_users; Type: TABLE; Schema: dmfw; Owner: -
--

CREATE TABLE dmfw.dmfw_twitter_users (
    user_id numeric NOT NULL,
    social_id character varying(100) NOT NULL,
    followers_count numeric,
    ipl_fan_score numeric,
    created_date timestamp without time zone
);


--
