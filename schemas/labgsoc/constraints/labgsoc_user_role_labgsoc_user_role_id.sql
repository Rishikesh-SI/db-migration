-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_user_role labgsoc_user_role_id
-- Type: CONSTRAINT

-- Name: labgsoc_user_role labgsoc_user_role_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_user_role
    ADD CONSTRAINT labgsoc_user_role_id PRIMARY KEY (user_role_id);


--
