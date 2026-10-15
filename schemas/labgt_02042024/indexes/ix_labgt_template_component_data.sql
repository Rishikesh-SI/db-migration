-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: ix_labgt_template_component_data
-- Type: INDEX

-- Name: ix_labgt_template_component_data; Type: INDEX; Schema: labgt_02042024; Owner: -
--

CREATE UNIQUE INDEX ix_labgt_template_component_data ON labgt_02042024.labgt_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
