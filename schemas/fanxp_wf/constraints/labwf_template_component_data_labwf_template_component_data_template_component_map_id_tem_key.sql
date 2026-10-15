-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_template_component_data labwf_template_component_data_template_component_map_id_tem_key
-- Type: CONSTRAINT

-- Name: labwf_template_component_data labwf_template_component_data_template_component_map_id_tem_key; Type: CONSTRAINT; Schema: fanxp_wf; Owner: -
--

ALTER TABLE ONLY fanxp_wf.labwf_template_component_data
    ADD CONSTRAINT labwf_template_component_data_template_component_map_id_tem_key UNIQUE (template_component_map_id, template_id, page_id);


--
