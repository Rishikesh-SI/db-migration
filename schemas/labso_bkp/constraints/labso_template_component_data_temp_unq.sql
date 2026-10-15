-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labso_template_component_data temp_unq; Type: CONSTRAINT; Schema: labso_bkp; Owner: -
--

ALTER TABLE ONLY labso_bkp.labso_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
