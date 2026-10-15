-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_user_role labjfc_user_role_id
-- Type: CONSTRAINT

-- Name: labjfc_user_role labjfc_user_role_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_user_role
    ADD CONSTRAINT labjfc_user_role_id PRIMARY KEY (user_role_id);


--
