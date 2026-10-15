-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_content_type_fields labgt_content_type_fields_pkey
-- Type: CONSTRAINT

-- Name: labgt_content_type_fields labgt_content_type_fields_pkey; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_content_type_fields
    ADD CONSTRAINT labgt_content_type_fields_pkey PRIMARY KEY (content_type_field_id);


--
