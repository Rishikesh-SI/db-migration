-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_labfih_template_component_map_is_deleted_active
-- Type: INDEX

-- Name: idx_labfih_template_component_map_is_deleted_active; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_labfih_template_component_map_is_deleted_active ON labfih.labfih_template_component_map_4_11_2024 USING btree (is_deleted, is_active);


--
