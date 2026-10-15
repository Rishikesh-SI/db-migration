-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ttgl_user_activity ttgl_user_activity_id
-- Type: CONSTRAINT

-- Name: ttgl_user_activity ttgl_user_activity_id; Type: CONSTRAINT; Schema: ttgl; Owner: -
--

ALTER TABLE ONLY ttgl.ttgl_user_activity
    ADD CONSTRAINT ttgl_user_activity_id PRIMARY KEY (user_activity_id);


--
