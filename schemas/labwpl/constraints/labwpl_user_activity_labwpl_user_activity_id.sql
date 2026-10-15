-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_user_activity labwpl_user_activity_id
-- Type: CONSTRAINT

-- Name: labwpl_user_activity labwpl_user_activity_id; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_user_activity
    ADD CONSTRAINT labwpl_user_activity_id PRIMARY KEY (user_activity_id);


--
