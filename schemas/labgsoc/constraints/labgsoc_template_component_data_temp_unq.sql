-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labgsoc_template_component_data temp_unq; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
