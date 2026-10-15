-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: ix_labsaw_template_component_data
-- Type: INDEX

-- Name: ix_labsaw_template_component_data; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE UNIQUE INDEX ix_labsaw_template_component_data ON labrstg.labrstg_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
