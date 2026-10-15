-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: labets_user_role labets_user_role_id
-- Type: CONSTRAINT

-- Name: labets_user_role labets_user_role_id; Type: CONSTRAINT; Schema: labets; Owner: -
--

ALTER TABLE ONLY labets.labets_user_role
    ADD CONSTRAINT labets_user_role_id PRIMARY KEY (user_role_id);


--
