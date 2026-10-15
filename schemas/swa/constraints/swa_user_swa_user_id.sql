-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_user swa_user_id
-- Type: CONSTRAINT

-- Name: swa_user swa_user_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_user
    ADD CONSTRAINT swa_user_id PRIMARY KEY (user_id);


--
