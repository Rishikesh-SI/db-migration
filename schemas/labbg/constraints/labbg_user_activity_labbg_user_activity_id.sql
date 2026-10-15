-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_user_activity labbg_user_activity_id
-- Type: CONSTRAINT

-- Name: labbg_user_activity labbg_user_activity_id; Type: CONSTRAINT; Schema: labbg; Owner: -
--

ALTER TABLE ONLY labbg.labbg_user_activity
    ADD CONSTRAINT labbg_user_activity_id PRIMARY KEY (user_activity_id);


--
