-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_admin_user gpn_admin_user_id
-- Type: CONSTRAINT

-- Name: gpn_admin_user gpn_admin_user_id; Type: CONSTRAINT; Schema: gpn; Owner: -
--

ALTER TABLE ONLY gpn.gpn_admin_user
    ADD CONSTRAINT gpn_admin_user_id PRIMARY KEY (admin_user_id);


--
