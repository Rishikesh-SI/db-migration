-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_user_activity ttmum_user_activity_id
-- Type: CONSTRAINT

-- Name: ttmum_user_activity ttmum_user_activity_id; Type: CONSTRAINT; Schema: ttmum; Owner: -
--

ALTER TABLE ONLY ttmum.ttmum_user_activity
    ADD CONSTRAINT ttmum_user_activity_id PRIMARY KEY (user_activity_id);


--
