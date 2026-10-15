-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dmfw
-- Object: dmfw_twitter_users dmfw_user_id_pk
-- Type: CONSTRAINT

-- Name: dmfw_twitter_users dmfw_user_id_pk; Type: CONSTRAINT; Schema: dmfw; Owner: -
--

ALTER TABLE ONLY dmfw.dmfw_twitter_users
    ADD CONSTRAINT dmfw_user_id_pk PRIMARY KEY (user_id);


--
