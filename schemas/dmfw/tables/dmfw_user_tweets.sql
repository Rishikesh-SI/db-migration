-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_user_tweets
-- Type: TABLE

-- Name: dmfw_user_tweets; Type: TABLE; Schema: dmfw; Owner: -
--

CREATE TABLE dmfw.dmfw_user_tweets (
    tweet_id numeric NOT NULL,
    user_id numeric NOT NULL,
    tweet_unique_id text NOT NULL,
    tweet text NOT NULL,
    re_tweet_count numeric,
    likes_count numeric,
    replies_count numeric,
    points numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    tweet_type text
);


--
