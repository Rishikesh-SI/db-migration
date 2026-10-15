-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_user_role labso_user_role_id
-- Type: CONSTRAINT

-- Name: labso_user_role labso_user_role_id; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_user_role
    ADD CONSTRAINT labso_user_role_id PRIMARY KEY (user_role_id);


--
