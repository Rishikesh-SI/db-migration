-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_user_activity labos_user_activity_id
-- Type: CONSTRAINT

-- Name: labos_user_activity labos_user_activity_id; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_user_activity
    ADD CONSTRAINT labos_user_activity_id PRIMARY KEY (user_activity_id);


--
