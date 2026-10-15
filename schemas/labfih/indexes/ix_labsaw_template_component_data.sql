-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: ix_labsaw_template_component_data
-- Type: INDEX

-- Name: ix_labsaw_template_component_data; Type: INDEX; Schema: labfih; Owner: -
--

CREATE UNIQUE INDEX ix_labsaw_template_component_data ON labfih.labfih_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
