-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_user_activity labrstg_user_activity_id
-- Type: CONSTRAINT

-- Name: labrstg_user_activity labrstg_user_activity_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_user_activity
    ADD CONSTRAINT labrstg_user_activity_id PRIMARY KEY (user_activity_id);


--
