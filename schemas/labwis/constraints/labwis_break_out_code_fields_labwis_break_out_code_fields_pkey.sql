-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_break_out_code_fields labwis_break_out_code_fields_pkey
-- Type: CONSTRAINT

-- Name: labwis_break_out_code_fields labwis_break_out_code_fields_pkey; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_break_out_code_fields
    ADD CONSTRAINT labwis_break_out_code_fields_pkey PRIMARY KEY (content_type_field_id);


--
