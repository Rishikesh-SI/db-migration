-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_active_non_deleted_template_component_map
-- Type: INDEX

-- Name: idx_active_non_deleted_template_component_map; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_active_non_deleted_template_component_map ON labfih.labfih_template_component_map USING btree (template_component_map_id) WHERE ((is_deleted = (0)::numeric) AND (is_active = (1)::numeric));


--
