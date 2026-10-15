-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_user labmsg_user_id
-- Type: CONSTRAINT

-- Name: labmsg_user labmsg_user_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_user
    ADD CONSTRAINT labmsg_user_id PRIMARY KEY (user_id);


--
