-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labdd_v1_template_component_data temp_unq; Type: CONSTRAINT; Schema: labdd_v1_30april24; Owner: -
--

ALTER TABLE ONLY labdd_v1_30april24.labdd_v1_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
