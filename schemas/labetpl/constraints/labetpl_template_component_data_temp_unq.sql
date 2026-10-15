-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labetpl_template_component_data temp_unq; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
