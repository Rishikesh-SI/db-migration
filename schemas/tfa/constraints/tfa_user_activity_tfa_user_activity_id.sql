-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_user_activity tfa_user_activity_id
-- Type: CONSTRAINT

-- Name: tfa_user_activity tfa_user_activity_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_user_activity
    ADD CONSTRAINT tfa_user_activity_id PRIMARY KEY (user_activity_id);


--
