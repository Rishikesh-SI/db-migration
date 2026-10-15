-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_action labmsg_action_id
-- Type: CONSTRAINT

-- Name: labmsg_action labmsg_action_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_action
    ADD CONSTRAINT labmsg_action_id PRIMARY KEY (action_id);


--
