-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labecn_v1_template_component_data temp_unq; Type: CONSTRAINT; Schema: labecn_v1_bkp_29012025; Owner: -
--

ALTER TABLE ONLY labecn_v1_bkp_29012025.labecn_v1_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
