-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_activity isl_user_activity_id
-- Type: CONSTRAINT

-- Name: isl_user_activity isl_user_activity_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_user_activity
    ADD CONSTRAINT isl_user_activity_id PRIMARY KEY (user_activity_id);


--
