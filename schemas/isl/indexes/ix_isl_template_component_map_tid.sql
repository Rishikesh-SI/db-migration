-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_template_component_map_tid
-- Type: INDEX

-- Name: ix_isl_template_component_map_tid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_template_component_map_tid ON isl.isl_template_component_map USING btree (template_id);


--
