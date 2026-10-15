-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_template_component_map_tid
-- Type: INDEX

-- Name: ix_hsl_template_component_map_tid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_template_component_map_tid ON hsl.hsl_template_component_map USING btree (template_id);


--
