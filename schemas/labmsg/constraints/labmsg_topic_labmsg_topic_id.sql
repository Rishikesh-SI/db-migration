-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_topic labmsg_topic_id
-- Type: CONSTRAINT

-- Name: labmsg_topic labmsg_topic_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_topic
    ADD CONSTRAINT labmsg_topic_id PRIMARY KEY (topic_id);


--
