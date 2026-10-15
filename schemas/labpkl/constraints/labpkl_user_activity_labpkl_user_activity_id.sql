-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_user_activity labpkl_user_activity_id
-- Type: CONSTRAINT

-- Name: labpkl_user_activity labpkl_user_activity_id; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_user_activity
    ADD CONSTRAINT labpkl_user_activity_id PRIMARY KEY (user_activity_id);


--
