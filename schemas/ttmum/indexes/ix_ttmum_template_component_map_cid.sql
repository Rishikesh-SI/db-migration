-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ix_ttmum_template_component_map_cid
-- Type: INDEX

-- Name: ix_ttmum_template_component_map_cid; Type: INDEX; Schema: ttmum; Owner: -
--

CREATE INDEX ix_ttmum_template_component_map_cid ON ttmum.ttmum_template_component_map USING btree (component_id);


--
