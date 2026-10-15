-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user_activity mum_user_activity_id
-- Type: CONSTRAINT

-- Name: dhm_user_activity mum_user_activity_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_user_activity
    ADD CONSTRAINT mum_user_activity_id PRIMARY KEY (user_activity_id);


--
