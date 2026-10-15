-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_labw88_template_component_data
-- Type: INDEX

-- Name: ix_labw88_template_component_data; Type: INDEX; Schema: labw88; Owner: -
--

CREATE UNIQUE INDEX ix_labw88_template_component_data ON labw88.labw88_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
