-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_user_role jafc_user_role_id
-- Type: CONSTRAINT

-- Name: jafc_user_role jafc_user_role_id; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_user_role
    ADD CONSTRAINT jafc_user_role_id PRIMARY KEY (user_role_id);


--
