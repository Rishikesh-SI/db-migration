-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_user_tweets_team_map
-- Type: TABLE

-- Name: dmfw_user_tweets_team_map; Type: TABLE; Schema: dmfw; Owner: -
--

CREATE TABLE dmfw.dmfw_user_tweets_team_map (
    user_tweets_team_map_id numeric NOT NULL,
    tweet_id numeric NOT NULL,
    team_id numeric NOT NULL,
    created_date timestamp without time zone
);


--
