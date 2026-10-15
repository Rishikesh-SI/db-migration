-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_user_role labmsg_user_role_id
-- Type: CONSTRAINT

-- Name: labmsg_user_role labmsg_user_role_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_user_role
    ADD CONSTRAINT labmsg_user_role_id PRIMARY KEY (user_role_id);


--
