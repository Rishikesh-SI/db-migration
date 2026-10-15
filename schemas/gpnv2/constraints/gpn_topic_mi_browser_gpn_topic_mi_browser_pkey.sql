-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_mi_browser gpn_topic_mi_browser_pkey
-- Type: CONSTRAINT

-- Name: gpn_topic_mi_browser gpn_topic_mi_browser_pkey; Type: CONSTRAINT; Schema: gpnv2; Owner: -
--

ALTER TABLE ONLY gpnv2.gpn_topic_mi_browser
    ADD CONSTRAINT gpn_topic_mi_browser_pkey PRIMARY KEY (topic_id, application_id);


--
