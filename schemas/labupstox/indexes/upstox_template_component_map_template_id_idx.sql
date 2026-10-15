-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_template_component_map_template_id_idx
-- Type: INDEX

-- Name: upstox_template_component_map_template_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_template_component_map_template_id_idx ON labupstox.labupstox_template_component_map USING btree (template_id);


--
