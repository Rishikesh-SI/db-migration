-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_content_type_fields labrr_content_type_field_id
-- Type: CONSTRAINT

-- Name: labrr_content_type_fields labrr_content_type_field_id; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_content_type_fields
    ADD CONSTRAINT labrr_content_type_field_id PRIMARY KEY (content_type_field_id);


--
