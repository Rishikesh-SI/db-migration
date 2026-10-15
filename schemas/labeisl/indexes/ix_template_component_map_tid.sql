-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labeisl.labeisl_template_component_map USING btree (template_id);


--
