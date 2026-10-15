-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labmi_v1_template_component_data temp_unq; Type: CONSTRAINT; Schema: labmi_v1_bkp; Owner: -
--

ALTER TABLE ONLY labmi_v1_bkp.labmi_v1_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
