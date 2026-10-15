-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_user_role labtri_user_role_id
-- Type: CONSTRAINT

-- Name: labtri_user_role labtri_user_role_id; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_user_role
    ADD CONSTRAINT labtri_user_role_id PRIMARY KEY (user_role_id);


--
