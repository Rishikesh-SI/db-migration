-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_topic tsk_topic_id
-- Type: CONSTRAINT

-- Name: tsk_topic tsk_topic_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_topic
    ADD CONSTRAINT tsk_topic_id PRIMARY KEY (topic_id);


--
