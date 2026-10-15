-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_web_user_timeline swa_user_timeline_id
-- Type: CONSTRAINT

-- Name: swa_web_user_timeline swa_user_timeline_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_web_user_timeline
    ADD CONSTRAINT swa_user_timeline_id PRIMARY KEY (user_timeline_id);


--
