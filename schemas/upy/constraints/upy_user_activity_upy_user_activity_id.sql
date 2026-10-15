-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_user_activity upy_user_activity_id
-- Type: CONSTRAINT

-- Name: upy_user_activity upy_user_activity_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_user_activity
    ADD CONSTRAINT upy_user_activity_id PRIMARY KEY (user_activity_id);


--
