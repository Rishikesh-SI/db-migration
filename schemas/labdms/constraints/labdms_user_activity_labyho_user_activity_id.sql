-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_user_activity labyho_user_activity_id
-- Type: CONSTRAINT

-- Name: labdms_user_activity labyho_user_activity_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_user_activity
    ADD CONSTRAINT labyho_user_activity_id PRIMARY KEY (user_activity_id);


--
