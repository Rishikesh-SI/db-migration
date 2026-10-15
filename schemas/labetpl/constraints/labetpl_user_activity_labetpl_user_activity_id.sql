-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_user_activity labetpl_user_activity_id
-- Type: CONSTRAINT

-- Name: labetpl_user_activity labetpl_user_activity_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_user_activity
    ADD CONSTRAINT labetpl_user_activity_id PRIMARY KEY (user_activity_id);


--
