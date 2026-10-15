-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_topic yho_topic_id
-- Type: CONSTRAINT

-- Name: yho_topic yho_topic_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_topic
    ADD CONSTRAINT yho_topic_id PRIMARY KEY (topic_master_id);


--
