-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_topic labsaw_topic_pkey
-- Type: CONSTRAINT

-- Name: labsaw_topic labsaw_topic_pkey; Type: CONSTRAINT; Schema: labsaw; Owner: -
--

ALTER TABLE ONLY labsaw.labsaw_topic
    ADD CONSTRAINT labsaw_topic_pkey PRIMARY KEY (topic_master_id);


--
