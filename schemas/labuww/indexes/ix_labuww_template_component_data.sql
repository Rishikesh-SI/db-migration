-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: ix_labuww_template_component_data
-- Type: INDEX

-- Name: ix_labuww_template_component_data; Type: INDEX; Schema: labuww; Owner: -
--

CREATE UNIQUE INDEX ix_labuww_template_component_data ON labuww.labuww_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
