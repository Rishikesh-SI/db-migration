-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_user_role mum_user_role_id
-- Type: CONSTRAINT

-- Name: tmm_user_role mum_user_role_id; Type: CONSTRAINT; Schema: tmm; Owner: -
--

ALTER TABLE ONLY tmm.tmm_user_role
    ADD CONSTRAINT mum_user_role_id PRIMARY KEY (user_role_id);


--
