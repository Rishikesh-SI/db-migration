-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labacko_template_component_data temp_unq; Type: CONSTRAINT; Schema: labacko; Owner: -
--

ALTER TABLE ONLY labacko.labacko_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
