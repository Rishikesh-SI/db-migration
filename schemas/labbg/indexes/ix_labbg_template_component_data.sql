-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: ix_labbg_template_component_data
-- Type: INDEX

-- Name: ix_labbg_template_component_data; Type: INDEX; Schema: labbg; Owner: -
--

CREATE UNIQUE INDEX ix_labbg_template_component_data ON labbg.labbg_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
