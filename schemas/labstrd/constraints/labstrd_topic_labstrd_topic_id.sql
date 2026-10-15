-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_topic labstrd_topic_id
-- Type: CONSTRAINT

-- Name: labstrd_topic labstrd_topic_id; Type: CONSTRAINT; Schema: labstrd; Owner: -
--

ALTER TABLE ONLY labstrd.labstrd_topic
    ADD CONSTRAINT labstrd_topic_id PRIMARY KEY (topic_id);


--
