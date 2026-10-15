-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_user_role labman_user_role_id
-- Type: CONSTRAINT

-- Name: labman_user_role labman_user_role_id; Type: CONSTRAINT; Schema: labman; Owner: -
--

ALTER TABLE ONLY labman.labman_user_role
    ADD CONSTRAINT labman_user_role_id PRIMARY KEY (user_role_id);


--
