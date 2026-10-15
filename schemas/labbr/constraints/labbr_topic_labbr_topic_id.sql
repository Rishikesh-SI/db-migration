-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_topic labbr_topic_id
-- Type: CONSTRAINT

-- Name: labbr_topic labbr_topic_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_topic
    ADD CONSTRAINT labbr_topic_id PRIMARY KEY (topic_id);


--
