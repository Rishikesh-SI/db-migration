-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic gpn_topic_pkey
-- Type: CONSTRAINT

-- Name: gpn_topic gpn_topic_pkey; Type: CONSTRAINT; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_topic
    ADD CONSTRAINT gpn_topic_pkey PRIMARY KEY (topic_id, application_id);


--
