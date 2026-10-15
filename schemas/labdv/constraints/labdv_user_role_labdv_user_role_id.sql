-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_user_role labdv_user_role_id
-- Type: CONSTRAINT

-- Name: labdv_user_role labdv_user_role_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_user_role
    ADD CONSTRAINT labdv_user_role_id PRIMARY KEY (user_role_id);


--
