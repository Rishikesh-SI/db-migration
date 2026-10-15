-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_template_component_data temp_unq
-- Type: CONSTRAINT

-- Name: labal_nassr_template_component_data temp_unq; Type: CONSTRAINT; Schema: labal_nassr; Owner: -
--

ALTER TABLE ONLY labal_nassr.labal_nassr_template_component_data
    ADD CONSTRAINT temp_unq UNIQUE (template_component_map_id, template_id, page_id);


--
