-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labos_template_component_data temp_unq; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
