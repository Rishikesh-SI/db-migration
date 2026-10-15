-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_user_role pbl_user_role_id
-- Type: CONSTRAINT

-- Name: pbl_user_role pbl_user_role_id; Type: CONSTRAINT; Schema: pbl; Owner: -
--

ALTER TABLE ONLY pbl.pbl_user_role
    ADD CONSTRAINT pbl_user_role_id PRIMARY KEY (user_role_id);


--
