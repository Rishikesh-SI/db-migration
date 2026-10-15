-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_topic mum_topic_id
-- Type: CONSTRAINT

-- Name: dhm_topic mum_topic_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_topic
    ADD CONSTRAINT mum_topic_id PRIMARY KEY (topic_id);


--
