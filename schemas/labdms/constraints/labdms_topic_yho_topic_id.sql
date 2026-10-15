-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_topic yho_topic_id
-- Type: CONSTRAINT

-- Name: labdms_topic yho_topic_id; Type: CONSTRAINT; Schema: labdms; Owner: -
--

ALTER TABLE ONLY labdms.labdms_topic
    ADD CONSTRAINT yho_topic_id PRIMARY KEY (topic_master_id);


--
