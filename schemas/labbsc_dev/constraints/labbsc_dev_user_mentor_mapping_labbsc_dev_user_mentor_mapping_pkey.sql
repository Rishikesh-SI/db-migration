-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_mentor_mapping labbsc_dev_user_mentor_mapping_pkey
-- Type: CONSTRAINT

-- Name: labbsc_dev_user_mentor_mapping labbsc_dev_user_mentor_mapping_pkey; Type: CONSTRAINT; Schema: labbsc_dev; Owner: -
--

ALTER TABLE ONLY labbsc_dev.labbsc_dev_user_mentor_mapping
    ADD CONSTRAINT labbsc_dev_user_mentor_mapping_pkey PRIMARY KEY (user_mentor_id);


--
