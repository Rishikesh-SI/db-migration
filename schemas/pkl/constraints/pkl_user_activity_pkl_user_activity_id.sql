-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: pkl_user_activity pkl_user_activity_id
-- Type: CONSTRAINT

-- Name: pkl_user_activity pkl_user_activity_id; Type: CONSTRAINT; Schema: pkl; Owner: -
--

ALTER TABLE ONLY pkl.pkl_user_activity
    ADD CONSTRAINT pkl_user_activity_id PRIMARY KEY (user_activity_id);


--
