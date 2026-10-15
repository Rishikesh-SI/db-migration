-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_author_action labmsg_author_action_id
-- Type: CONSTRAINT

-- Name: labmsg_author_action labmsg_author_action_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_author_action
    ADD CONSTRAINT labmsg_author_action_id PRIMARY KEY (author_action_id);


--
