-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_template_component_data templ
-- Type: CONSTRAINT

-- Name: labisl_v1_template_component_data templ; Type: CONSTRAINT; Schema: labisl_v1; Owner: -
--

ALTER TABLE ONLY labisl_v1.labisl_v1_template_component_data
    ADD CONSTRAINT templ UNIQUE (template_component_map_id, template_id, page_id);


--
