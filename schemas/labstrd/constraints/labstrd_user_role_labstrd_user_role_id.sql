-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_user_role labstrd_user_role_id
-- Type: CONSTRAINT

-- Name: labstrd_user_role labstrd_user_role_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_user_role
    ADD CONSTRAINT labstrd_user_role_id PRIMARY KEY (user_role_id);


--
