-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_user_activity dd_user_activity_id
-- Type: CONSTRAINT

-- Name: dd_user_activity dd_user_activity_id; Type: CONSTRAINT; Schema: dd; Owner: -
--

ALTER TABLE ONLY dd.dd_user_activity
    ADD CONSTRAINT dd_user_activity_id PRIMARY KEY (user_activity_id);


--
