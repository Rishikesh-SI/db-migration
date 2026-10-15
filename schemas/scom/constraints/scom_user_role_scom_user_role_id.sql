-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: scom_user_role scom_user_role_id
-- Type: CONSTRAINT

-- Name: scom_user_role scom_user_role_id; Type: CONSTRAINT; Schema: scom; Owner: -
--

ALTER TABLE ONLY scom.scom_user_role
    ADD CONSTRAINT scom_user_role_id PRIMARY KEY (user_role_id);


--
