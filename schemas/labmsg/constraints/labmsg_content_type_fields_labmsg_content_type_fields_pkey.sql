-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_content_type_fields labmsg_content_type_fields_pkey
-- Type: CONSTRAINT

-- Name: labmsg_content_type_fields labmsg_content_type_fields_pkey; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_content_type_fields
    ADD CONSTRAINT labmsg_content_type_fields_pkey PRIMARY KEY (content_type_field_id);


--
