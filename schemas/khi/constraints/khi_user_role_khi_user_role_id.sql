-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_user_role khi_user_role_id
-- Type: CONSTRAINT

-- Name: khi_user_role khi_user_role_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_user_role
    ADD CONSTRAINT khi_user_role_id PRIMARY KEY (user_role_id);


--
