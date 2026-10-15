-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_uuid_storage labgt_uuid_storage_pkey
-- Type: CONSTRAINT

-- Name: labgt_uuid_storage labgt_uuid_storage_pkey; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_uuid_storage
    ADD CONSTRAINT labgt_uuid_storage_pkey PRIMARY KEY (uuid_id);


--
