-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_labfih_entity_language_map_master_active
-- Type: INDEX

-- Name: idx_labfih_entity_language_map_master_active; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_labfih_entity_language_map_master_active ON labfih.labfih_entity_language_map USING btree (entity_master_id) WHERE ((is_active = (1)::numeric) AND (is_deleted = (0)::numeric));


--
