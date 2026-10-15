-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_template_component_data templ
-- Type: CONSTRAINT

-- Name: labkc_v1_template_component_data templ; Type: CONSTRAINT; Schema: labkc_v1; Owner: -
--

ALTER TABLE ONLY labkc_v1.labkc_v1_template_component_data
    ADD CONSTRAINT templ UNIQUE (template_id, template_component_map_id, page_id);


--
