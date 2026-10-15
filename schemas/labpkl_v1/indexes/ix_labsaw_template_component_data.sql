-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_labsaw_template_component_data
-- Type: INDEX

-- Name: ix_labsaw_template_component_data; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE UNIQUE INDEX ix_labsaw_template_component_data ON labpkl_v1.labpkl_v1_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
