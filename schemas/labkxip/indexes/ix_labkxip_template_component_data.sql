-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: ix_labkxip_template_component_data
-- Type: INDEX

-- Name: ix_labkxip_template_component_data; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE UNIQUE INDEX ix_labkxip_template_component_data ON labkxip.labkxip_template_component_data USING btree (template_component_map_id, page_id, template_id, component_id);


--
