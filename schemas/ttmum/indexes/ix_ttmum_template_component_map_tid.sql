-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_template_component_map_tid
-- Type: INDEX

-- Name: ix_ttmum_template_component_map_tid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_template_component_map_tid ON ttmum.ttmum_template_component_map USING btree (template_id);


--
