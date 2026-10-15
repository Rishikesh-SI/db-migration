-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: kxp_topic kxp_topic_id
-- Type: CONSTRAINT

-- Name: kxp_topic kxp_topic_id; Type: CONSTRAINT; Schema: kxp; Owner: -
--

ALTER TABLE ONLY kxp.kxp_topic
    ADD CONSTRAINT kxp_topic_id PRIMARY KEY (topic_id);


--
