-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_user_role tcs_user_role_id
-- Type: CONSTRAINT

-- Name: tcs_user_role tcs_user_role_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_user_role
    ADD CONSTRAINT tcs_user_role_id PRIMARY KEY (user_role_id);


--
