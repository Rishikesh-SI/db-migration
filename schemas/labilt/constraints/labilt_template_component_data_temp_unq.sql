-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labilt_template_component_data temp_unq; Type: CONSTRAINT; Schema: labilt; Owner: -
--

ALTER TABLE ONLY labilt.labilt_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
