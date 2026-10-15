-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_template_component_data templ
-- Type: CONSTRAINT

-- Name: labtri_template_component_data templ; Type: CONSTRAINT; Schema: labtri; Owner: -
--

ALTER TABLE ONLY labtri.labtri_template_component_data
    ADD CONSTRAINT templ UNIQUE (template_component_map_id, template_id, page_id);


--
