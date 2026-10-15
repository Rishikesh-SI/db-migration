-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_user tcs_user_id
-- Type: CONSTRAINT

-- Name: tcs_user tcs_user_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_user
    ADD CONSTRAINT tcs_user_id PRIMARY KEY (user_id);


--
