-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labsm_template_component_data temp_unq; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
