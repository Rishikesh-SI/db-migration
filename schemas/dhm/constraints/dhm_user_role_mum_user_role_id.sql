-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user_role mum_user_role_id
-- Type: CONSTRAINT

-- Name: dhm_user_role mum_user_role_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_user_role
    ADD CONSTRAINT mum_user_role_id PRIMARY KEY (user_role_id);


--
