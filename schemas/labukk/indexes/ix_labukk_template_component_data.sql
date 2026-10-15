-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labukk
-- Object: ix_labukk_template_component_data
-- Type: INDEX

-- Name: ix_labukk_template_component_data; Type: INDEX; Schema: labukk; Owner: -
--

CREATE UNIQUE INDEX ix_labukk_template_component_data ON labukk.labukk_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
