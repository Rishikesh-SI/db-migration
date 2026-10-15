-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_user_role labisp_user_role_id
-- Type: CONSTRAINT

-- Name: labisp_user_role labisp_user_role_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_user_role
    ADD CONSTRAINT labisp_user_role_id PRIMARY KEY (user_role_id);


--
