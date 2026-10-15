-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_topic tfa_topic_id
-- Type: CONSTRAINT

-- Name: tfa_topic tfa_topic_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_topic
    ADD CONSTRAINT tfa_topic_id PRIMARY KEY (topic_id);


--
