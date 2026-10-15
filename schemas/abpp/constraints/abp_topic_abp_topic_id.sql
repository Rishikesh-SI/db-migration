-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_topic abp_topic_id
-- Type: CONSTRAINT

-- Name: abp_topic abp_topic_id; Type: CONSTRAINT; Schema: abpp; Owner: -
--

ALTER TABLE ONLY abpp.abp_topic
    ADD CONSTRAINT abp_topic_id PRIMARY KEY (topic_master_id);


--
