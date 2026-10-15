-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user_activity labbr_user_activity_id
-- Type: CONSTRAINT

-- Name: labbr_user_activity labbr_user_activity_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_user_activity
    ADD CONSTRAINT labbr_user_activity_id PRIMARY KEY (user_activity_id);


--
