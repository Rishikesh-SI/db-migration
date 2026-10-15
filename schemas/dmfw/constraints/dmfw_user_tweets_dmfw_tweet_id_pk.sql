-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_user_tweets dmfw_tweet_id_pk
-- Type: CONSTRAINT

-- Name: dmfw_user_tweets dmfw_tweet_id_pk; Type: CONSTRAINT; Schema: dmfw; Owner: -
--

ALTER TABLE ONLY dmfw.dmfw_user_tweets
    ADD CONSTRAINT dmfw_tweet_id_pk PRIMARY KEY (tweet_id);


--
