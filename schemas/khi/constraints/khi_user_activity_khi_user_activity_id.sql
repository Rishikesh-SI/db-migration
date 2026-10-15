-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_user_activity khi_user_activity_id
-- Type: CONSTRAINT

-- Name: khi_user_activity khi_user_activity_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_user_activity
    ADD CONSTRAINT khi_user_activity_id PRIMARY KEY (user_activity_id);


--
