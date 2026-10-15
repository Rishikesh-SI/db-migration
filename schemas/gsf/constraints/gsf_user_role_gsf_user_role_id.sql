-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_user_role gsf_user_role_id
-- Type: CONSTRAINT

-- Name: gsf_user_role gsf_user_role_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_user_role
    ADD CONSTRAINT gsf_user_role_id PRIMARY KEY (user_role_id);


--
