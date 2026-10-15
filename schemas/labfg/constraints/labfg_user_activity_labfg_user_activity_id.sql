-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_user_activity labfg_user_activity_id
-- Type: CONSTRAINT

-- Name: labfg_user_activity labfg_user_activity_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_user_activity
    ADD CONSTRAINT labfg_user_activity_id PRIMARY KEY (user_activity_id);


--
