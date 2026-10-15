-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: idx_labrr_entity_role_map_source_object
-- Type: INDEX

-- Name: idx_labrr_entity_role_map_source_object; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX idx_labrr_entity_role_map_source_object ON labrr.labrr_entity_role_map USING btree (source_object_id);


--
