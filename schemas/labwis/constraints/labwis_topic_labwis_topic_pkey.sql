-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_topic labwis_topic_pkey
-- Type: CONSTRAINT

-- Name: labwis_topic labwis_topic_pkey; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_topic
    ADD CONSTRAINT labwis_topic_pkey PRIMARY KEY (topic_master_id);


--
