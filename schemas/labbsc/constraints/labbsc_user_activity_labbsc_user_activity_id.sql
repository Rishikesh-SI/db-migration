-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_activity labbsc_user_activity_id
-- Type: CONSTRAINT

-- Name: labbsc_user_activity labbsc_user_activity_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_user_activity
    ADD CONSTRAINT labbsc_user_activity_id PRIMARY KEY (user_activity_id);


--
