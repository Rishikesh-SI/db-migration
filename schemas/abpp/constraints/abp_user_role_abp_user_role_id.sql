-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_user_role abp_user_role_id
-- Type: CONSTRAINT

-- Name: abp_user_role abp_user_role_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_user_role
    ADD CONSTRAINT abp_user_role_id PRIMARY KEY (user_role_id);


--
