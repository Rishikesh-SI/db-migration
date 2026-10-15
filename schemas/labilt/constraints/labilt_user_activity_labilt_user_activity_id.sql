-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_user_activity labilt_user_activity_id
-- Type: CONSTRAINT

-- Name: labilt_user_activity labilt_user_activity_id; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_user_activity
    ADD CONSTRAINT labilt_user_activity_id PRIMARY KEY (user_activity_id);


--
