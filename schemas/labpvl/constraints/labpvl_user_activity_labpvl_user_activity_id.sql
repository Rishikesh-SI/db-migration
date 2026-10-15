-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_user_activity labpvl_user_activity_id
-- Type: CONSTRAINT

-- Name: labpvl_user_activity labpvl_user_activity_id; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_user_activity
    ADD CONSTRAINT labpvl_user_activity_id PRIMARY KEY (user_activity_id);


--
