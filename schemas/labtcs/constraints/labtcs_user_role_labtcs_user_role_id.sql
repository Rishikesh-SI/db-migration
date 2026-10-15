-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_user_role labtcs_user_role_id
-- Type: CONSTRAINT

-- Name: labtcs_user_role labtcs_user_role_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_user_role
    ADD CONSTRAINT labtcs_user_role_id PRIMARY KEY (user_role_id);


--
