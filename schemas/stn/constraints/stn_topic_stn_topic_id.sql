-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_topic stn_topic_id
-- Type: CONSTRAINT

-- Name: stn_topic stn_topic_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_topic
    ADD CONSTRAINT stn_topic_id PRIMARY KEY (topic_id);


--
