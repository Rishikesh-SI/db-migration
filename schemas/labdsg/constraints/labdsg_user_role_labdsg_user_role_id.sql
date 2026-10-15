-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_user_role labdsg_user_role_id
-- Type: CONSTRAINT

-- Name: labdsg_user_role labdsg_user_role_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_user_role
    ADD CONSTRAINT labdsg_user_role_id PRIMARY KEY (user_role_id);


--
