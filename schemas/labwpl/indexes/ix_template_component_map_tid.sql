-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labwpl; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labwpl.labwpl_template_component_map USING btree (template_id);


--
