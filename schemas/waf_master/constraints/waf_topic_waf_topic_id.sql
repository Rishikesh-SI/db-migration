-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_topic waf_topic_id
-- Type: CONSTRAINT

-- Name: waf_topic waf_topic_id; Type: CONSTRAINT; Schema: waf_master; Owner: -
--

ALTER TABLE ONLY waf_master.waf_topic
    ADD CONSTRAINT waf_topic_id PRIMARY KEY (topic_id);


--
