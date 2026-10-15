-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_topic labisp_topic_id
-- Type: CONSTRAINT

-- Name: labisp_topic labisp_topic_id; Type: CONSTRAINT; Schema: labisp; Owner: -
--

ALTER TABLE ONLY labisp.labisp_topic
    ADD CONSTRAINT labisp_topic_id PRIMARY KEY (topic_master_id);


--
