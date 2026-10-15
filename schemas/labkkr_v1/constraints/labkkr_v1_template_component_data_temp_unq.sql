-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labkkr_v1_template_component_data temp_unq; Type: CONSTRAINT; Schema: labkkr_v1; Owner: -
--

ALTER TABLE ONLY labkkr_v1.labkkr_v1_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
