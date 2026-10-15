-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_user_role cfc_user_role_id
-- Type: CONSTRAINT

-- Name: cfc_user_role cfc_user_role_id; Type: CONSTRAINT; Schema: cfc; Owner: -
--

ALTER TABLE ONLY cfc.cfc_user_role
    ADD CONSTRAINT cfc_user_role_id PRIMARY KEY (user_role_id);


--
