-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_template_component_data templ
-- Type: CONSTRAINT

-- Name: labspz_v1_template_component_data templ; Type: CONSTRAINT; Schema: labspz_v1; Owner: -
--

ALTER TABLE ONLY labspz_v1.labspz_v1_template_component_data
    ADD CONSTRAINT templ UNIQUE (template_component_map_id, template_id, page_id);


--
